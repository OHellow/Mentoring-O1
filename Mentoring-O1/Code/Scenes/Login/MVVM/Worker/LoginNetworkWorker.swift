import Foundation

protocol LoginNetworkLogic {
    func requestToken() async -> Result<AuthResponse, RequestError>
    func logIn(email: String, password: String, token: String) async -> Result<AuthResponse, RequestError>
}

final class LoginNetworkWorker: LoginNetworkLogic {
    private let apiService: AuthServiceable

    init(apiService: AuthServiceable) {
        self.apiService = apiService
    }

    func requestToken() async -> Result<AuthResponse, RequestError> {
        return await apiService.requestToken()
    }

    func logIn(email: String, password: String, token: String) async -> Result<AuthResponse, RequestError> {
        return await apiService.login(email: email, password: password, token: token)
    }
}
