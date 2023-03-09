import Foundation

enum AuthEndpoint {
    case requestToken
    case createSessionWithLogin(email: String, password: String, token: String)
    case logout
}

extension AuthEndpoint: Endpoint {
    var path: String {
        switch self {
        case .requestToken:
            return "/3/authentication/token/new"
        case .createSessionWithLogin:
            return "/3/authentication/token/validate_with_login"
        case .logout:
            return "/3/authentication/session"
        }
    }

    var method: RequestMethod {
        switch self {
        case .requestToken:
            return .get
        case .createSessionWithLogin:
            return .post
        case .logout:
            return .delete
        }
    }

    var header: [String: String]? {
        let accessToken = "a122e1727b06b2c9f0d6dba1d231ed38"
        switch self {
        case .requestToken, .createSessionWithLogin, .logout:
            return [
                "Authorization": "Bearer \(accessToken)",
                "Content-Type": "application/json;charset=utf-8"
            ]
        }
    }

    var body: [String: Any]? {
        switch self {
        case .createSessionWithLogin(let email, let password, let token):
            return ["username": email,
                    "password": password,
                    "request_token": token]
        case .requestToken, .logout:
            return nil
        }
    }

    var params: [String: Any]? {
        switch self {
        case .requestToken, .createSessionWithLogin, .logout:
            return nil
        }
    }
}
