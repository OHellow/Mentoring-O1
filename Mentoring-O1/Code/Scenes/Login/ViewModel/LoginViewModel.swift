import Foundation

final class LoginViewModel: LoginViewModelProtocol {
    private var email = ""
    private var password = ""
    var error: Observable<RequestError?> = Observable(nil)
    var startLoading = Observable(false)

    let apiService: AuthServiceable

    init(apiService: AuthServiceable) {
        self.apiService = apiService
    }
    func updateCredentials(email: String, password: String) {
        self.email = email
        self.password = password
    }

    func requestToken(completion: @escaping () -> Void) {
        startLoading.value = true
        Task(priority: .background) {
            let result = await apiService.requestToken()
            switch result {
            case .success(let response):
                login(with: response.requestToken, completion: completion)
            case .failure(let error):
                startLoading.value = false
                self.error.value = error
            }
        }
    }

    private func login(with token: String?, completion: @escaping () -> Void) {
        Task(priority: .background) {
            let result = await apiService.login(email: email, password: password, token: token ?? "")
            startLoading.value = false
            switch result {
            case .success(_):
                completion()
            case .failure(let error):
                self.error.value = error
            }
        }
    }
}
