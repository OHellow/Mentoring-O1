import SwiftUI
import Combine

final class UpcomingMoviesModel: ObservableObject {
    @Published var movies: [Movie] = []
    @ObservedObject var upcomingMoviesSate: UpComingMoviesState

    private var interactor: UpcomingInteractorProtocol
    private var router: UpcomingRoutingLogic

    private var cancellables: Set<AnyCancellable> = []

    init(interactor: UpcomingInteractorProtocol, router: UpcomingRoutingLogic, state: UpComingMoviesState) {
        self.interactor = interactor
        self.router = router
        self.upcomingMoviesSate = state
    }

    @MainActor
    func fetchMovies() {
        upcomingMoviesSate.isLoading = true
        interactor.fetchMovies()
            .receive(on: DispatchQueue.main)
            .sink { [weak self] completion in
                guard let self = self else { return }
                self.upcomingMoviesSate.isLoading = false
                if case let .failure(error) = completion {
                    self.upcomingMoviesSate.errorWrapper?.error = error.customMessage
                }
            } receiveValue: { [weak self] movies in
                guard let self = self else { return }
                self.movies.append(contentsOf: movies)
            }
            .store(in: &cancellables)
    }

    func navigateToMovieDetailsScene(uid: Int?) {
        guard let uid = uid else { return }
        router.showDetails(movieId: uid)
    }
}

