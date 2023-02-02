import Foundation

protocol AuthServiceable {
    func requestToken() async -> Result<AuthResponse, RequestError>
    func login(email: String, password: String, token: String) async -> Result<AuthResponse, RequestError>
    func logout() async -> Result<Bool, RequestError>
}

struct AuthClient: APIClient, AuthServiceable {
    func requestToken() async -> Result<AuthResponse, RequestError> {
        return await sendRequest(endpoint: AuthEndpoint.requestToken, responseModel: AuthResponse.self)
    }

    func login(email: String, password: String, token: String) async -> Result<AuthResponse, RequestError> {
        return await sendRequest(endpoint: AuthEndpoint.createSessionWithLogin(email: email,
                                                                               password: password,
                                                                               token: token), responseModel: AuthResponse.self)
    }

    func logout() async -> Result<Bool, RequestError> {
        return await sendRequest(endpoint: AuthEndpoint.logout, responseModel: Bool.self)
    }
}
