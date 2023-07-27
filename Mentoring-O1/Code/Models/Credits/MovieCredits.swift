import Foundation

struct MovieCredits: Decodable {
    let id: Int
    let cast: [Cast]
    let crew: [Crew]

    private enum CodingKeys: String, CodingKey {
        case id
        case cast
        case crew
    }
}
