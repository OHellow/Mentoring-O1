import UIKit

protocol LoginRoutingLogic {
    func showAlert(title: String, message: String)
    func showUpcomingScene()
}

class LoginRouter: LoginRoutingLogic {
    weak var viewController: UIViewController?

    func showUpcomingScene() {
        let upcomingScene = ScreenFabric.makeUpcomingScene()
        viewController?.navigationController?.setViewControllers([upcomingScene], animated: true)
    }

    func showAlert(title: String, message: String) {
        let alert = UIAlertController(title: title, message: message, preferredStyle: .alert)
        alert.addAction(UIAlertAction(title: "Ok", style: .default, handler: nil))
        viewController?.present(alert, animated: true)
    }
}
