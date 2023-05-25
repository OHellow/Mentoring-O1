import UIKit

final class ScreenFabricUpcomingMovies {
    static func makeUpcomingScene() -> UIViewController {
        let apiService = MovieClient()
        let presenter = UpcomingPresenter()
        let interactor = UpcomingInteractor()
        let router = UpcomingMoviesRouter()
        let worker = UpcomingNetworkWorker(apiService: apiService)
        let viewController = UpcomingViewController()

        interactor.presenter = presenter
        interactor.networkWorker = worker
        presenter.viewController = viewController
        viewController.interactor = interactor
        viewController.router = router
        router.viewController = viewController
        return viewController
    }
}
