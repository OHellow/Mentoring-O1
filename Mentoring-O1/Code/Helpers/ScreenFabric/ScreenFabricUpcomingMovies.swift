import UIKit

final class ScreenFabricUpcomingMovies {
    static func makeUpcomingScene() -> UIViewController {
        let apiService = MovieClient()
        let interactor = UpcomingInteractor()
        let router = UpcomingMoviesRouter()
        let worker = UpcomingNetworkWorker(apiService: apiService)
        let viewModel = UpcomingMoviesViewModel(interactor: interactor, router: router)
        let viewController = UpcomingViewController(viewModel: viewModel)

        interactor.networkWorker = worker
        router.viewController = viewController
        return viewController
    }
}
