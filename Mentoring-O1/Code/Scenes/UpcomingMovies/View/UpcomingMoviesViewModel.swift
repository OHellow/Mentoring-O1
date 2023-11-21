import Foundation

final class UpcomingMoviesViewModel: ObservableObject {
    @Published var movies: [Movie] = []
    @Published var isLoading: Bool = false
    @Published var showingAlert = false
    @Published var errorMessage: String = ""

    private var interactor: UpcomingInteractorProtocol
    private var router: UpcomingRoutingLogic

    init(interactor: UpcomingInteractorProtocol, router: UpcomingRoutingLogic) {
        self.interactor = interactor
        self.router = router
    }

    func fetchMovies() {
        interactor.fetchMovies()
    }

    func navigateToMovieDetailsScene(uid: Int?) {
        guard let uid = uid else { return }
        router.showDetails(movieId: uid)
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

extension UpcomingMoviesViewModel: UpcomingInteractorDelegate {
    @MainActor
    func fetchResult(result: Result<[Movie], RequestError>) {
        hideLoading()
        switch result {
        case .success(let movies):
            self.movies.append(contentsOf: movies)
        case .failure(let error):
            errorMessage = error.customMessage
        }
    }
}
