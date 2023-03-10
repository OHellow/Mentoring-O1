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

    static func makeDetailsScene(movieId: Int) -> UIViewController {
        let apiService = MovieClient()
        let viewModel = DetailsViewModel(apiService: apiService, movieId: movieId)
        let viewController = DetailsViewController(viewModel: viewModel)
        return viewController
    }

    static func makeLoginScene() -> UIViewController {
        let apiService = AuthClient()
        let viewModel = LoginViewModel(apiService: apiService)
        let viewController = LoginViewController(viewModel: viewModel)
        return viewController
    }
}
