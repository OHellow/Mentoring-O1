import Foundation

struct AuthResponse: Decodable {
    let success: Bool
    let expiresAt: String?
    let requestToken: String?

    enum CodingKeys: String, CodingKey {
        case success
        case expiresAt = "expires_at"
        case requestToken = "request_token"
    }
}
