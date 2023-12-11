import Foundation
import Combine

final class UpcomingMoviesViewModel: ObservableObject {
    @Published var movies: [Movie] = []
    @Published var isLoading: Bool = false
    @Published var showingAlert = false
    @Published var errorMessage: String = ""

    private var interactor: UpcomingInteractorProtocol
    private var router: UpcomingRoutingLogic

    private var cancellables: Set<AnyCancellable> = []

    init(interactor: UpcomingInteractorProtocol, router: UpcomingRoutingLogic) {
        self.interactor = interactor
        self.router = router
    }

    @MainActor
    func fetchMovies() {
        showLoading()
        interactor.fetchMovies()
            .receive(on: DispatchQueue.main)
            .sink { [weak self] completion in
                guard let self = self else { return }
                self.hideLoading()
                if case let .failure(error) = completion {
                    self.errorMessage = error.customMessage
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

    @MainActor
    func showLoading() {
        isLoading = true
    }

    @MainActor
    func hideLoading() {
        isLoading = false
    }
}
