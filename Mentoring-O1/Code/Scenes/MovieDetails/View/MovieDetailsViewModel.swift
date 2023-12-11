import Foundation
import Combine

final class MovieDetailsViewModel: ObservableObject {
    @Published var movie: Movie?
    @Published var relatedMovies: [RelatedMovie] = []
    @Published var movieCast: [Cast] = []
    @Published var isLoading: Bool = false
    @Published var showingAlert = false
    @Published var errorMessage: String = ""
    private var movieId: Int
    private let relatedMoviesPage = 1

    private var interactor: MovieDetailsInteractorProtocol
    private var router: MovieDetailsRoutingLogic

    private var cancellables: Set<AnyCancellable> = []

    init(movieId: Int, interactor: MovieDetailsInteractorProtocol, router: MovieDetailsRoutingLogic) {
        self.interactor = interactor
        self.router = router
        self.movieId = movieId
    }

    func navigateToMovieDetailsScene(uid: Int?) {}

    @MainActor
    private func setupCombine() {
        let movieDetailPublisher = interactor.fetchMovieDetail(id: movieId)
        let movieCreditsPublisher = interactor.fetchMovieCredits(id: movieId)
        let movieTrailersPublisher = interactor.fetchTrailersForMovie(id: movieId)
        let relatedMoviesPublisher = interactor.fetchRelatedMovies(id: movieId, page: relatedMoviesPage)

        Publishers.CombineLatest4(
            movieDetailPublisher,
            movieCreditsPublisher,
            movieTrailersPublisher,
            relatedMoviesPublisher
        )
        .handleEvents(receiveSubscription: { [weak self] _ in
            self?.showLoading()
        }, receiveCompletion: { [weak self] completion in
            guard case let .failure(error) = completion else { return }
            self?.hideLoading()
            self?.errorMessage = error.customMessage
        }, receiveCancel: { [weak self] in
            self?.hideLoading()
        })
        .sink(receiveCompletion: { [weak self] completion in
            guard case let .failure(error) = completion else { return }
            self?.hideLoading()
            self?.errorMessage = error.customMessage
        }, receiveValue: { [weak self] values in
            guard let self = self else { return }

            let (movieDetail, movieCredits, movieTrailers, relatedMovies) = values

            self.movie = movieDetail
            self.movieCast = movieCredits.cast
            self.relatedMovies = relatedMovies.results
        })
        .store(in: &cancellables)
    }

    @MainActor
    func showLoading() {
        isLoading = true
    }

    @MainActor
    func hideLoading() {
        isLoading = false
    }
}
