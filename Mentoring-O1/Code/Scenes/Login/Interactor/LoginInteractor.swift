import Foundation

protocol LoginInteractorDelegate: AnyObject {
    func loginResult(result: Result<Void, Error>)
}

protocol LoginInteractorProtocol {
    func didTapLogin(with email: String, password: String)
}

final class LoginInteractor {
    var networkWorker: LoginNetworkLogic?

    weak var delegate: LoginInteractorDelegate?

    private var email = ""
    private var password = ""
}

extension LoginInteractor: LoginInteractorProtocol {
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
                delegate?.loginResult(result: .failure(error))
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
                delegate?.loginResult(result: .success(()))
            case .failure(let error):
                delegate?.loginResult(result: .failure(error))
            case .none:
                break
            }
        }
    }
}
