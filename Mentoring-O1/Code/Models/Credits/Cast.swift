import Foundation

struct Cast: Decodable, Identifiable {
    var id = UUID()
    let name: String
    let profilePath: String?

    private enum CodingKeys: String, CodingKey {
        case name
        case profilePath = "profile_path"
    }
}
