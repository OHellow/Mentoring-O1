import UIKit

class ScreenFabric {
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

    static func makeDetailsScene(dataStore: MovieDetailDataStore) -> UIViewController {
        let apiService = MovieClient()
        let presenter = MovieDetailsPresenter()
        let interactor = MovieDetailsInteractor()
        let router = MovieDetailsRouter()
        let worker = MovieDetailsWorker(apiService: apiService)
        let viewController = MovieDetailsViewController()

        interactor.presenter = presenter
        interactor.networkWorker = worker
        presenter.viewController = viewController
        viewController.interactor = interactor
        viewController.router = router
        router.viewController = viewController
        router.dataStore = dataStore
        return viewController

    }

    static func makeLoginScene() -> UIViewController {
        let apiService = AuthClient()
        let presenter = LoginPresenter()
        let interactor = LoginInteractor()
        let router = LoginRouter()
        let worker = LoginNetworkWorker(apiService: apiService)
        let viewController = LoginViewController()

        interactor.presenter = presenter
        interactor.networkWorker = worker
        presenter.viewController = viewController
        viewController.interactor = interactor
        viewController.router = router
        router.viewController = viewController
        return viewController
    }
}
