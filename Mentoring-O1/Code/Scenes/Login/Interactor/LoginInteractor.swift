import Foundation

final class LoginInteractor {
    var presenter: LoginPresenterInput?
    var networkWorker: LoginNetworkLogic?

    private var email = ""
    private var password = ""
}

extension LoginInteractor: LoginViewControllerInput {
    func didTapLogin(with email: String, password: String) {
        self.email = email
        self.password = password
        requestToken()
    }

    private func requestToken() {
        Task(priority: .background) {
            let result = await networkWorker?.requestToken()
            switch result {
            case .success(let response):
                login(with: response.requestToken)
            case .failure(let error):
                presenter?.showError(error: error)
            case .none:
                break
            }
        }
    }

    private func login(with token: String?) {
        Task(priority: .background) {
            let result = await networkWorker?.logIn(email: email, password: password, token: token ?? "")
            switch result {
            case .success(_):
                presenter?.showUpcomingMoviesScene()
            case .failure(let error):
                presenter?.showError(error: error)
            case .none:
                break
            }
        }
    }
}
