import UIKit

protocol LoginRoutingLogic {
    func showUpcomingScene()
}

class LoginRouter: LoginRoutingLogic {
    weak var viewController: UIViewController?

    func showUpcomingScene() {
        let upcomingScene = ScreenFabricUpcomingMovies.makeUpcomingScene()
        viewController?.navigationController?.setViewControllers([upcomingScene], animated: true)
    }
}
