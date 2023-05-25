import UIKit

final class ScreenFabricLogin {
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
