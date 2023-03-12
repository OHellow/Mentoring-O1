import Foundation

protocol LoginPresenterInput {
    func showUpcomingMoviesScene()
    func showError(error: Error)
    func showLoading()
    func hideLoading()
}

final class LoginPresenter: LoginPresenterInput {
    weak var viewController: LoginViewControllerOutput?

    func showUpcomingMoviesScene() {
        viewController?.showUpcomingMoviesScene()
    }

    func showError(error: Error) {
        viewController?.showError(error: error)
    }

    func showLoading() {
        viewController?.showLoading()
    }

    func hideLoading() {
        viewController?.hideLoading()
    }
}
