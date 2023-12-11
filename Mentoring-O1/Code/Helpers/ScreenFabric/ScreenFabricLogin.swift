import UIKit

final class ScreenFabricLogin {
    static func makeLoginScene() -> UIViewController {
        let apiService = AuthClient()
        let interactor = LoginInteractor()
        let router = LoginRouter()
        let worker = LoginNetworkWorker(apiService: apiService)
        let viewModel = LoginViewModel(interactor: interactor, router: router)
        let viewController = LoginViewController(viewModel: viewModel)

        interactor.networkWorker = worker
        interactor.delegate = viewModel
        router.viewController = viewController
        return viewController
    }
}
