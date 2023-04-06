import Foundation

struct RelatedMovie: Decodable {
    let id: Int
    let title: String
    let posterPath: String?
    let releaseDate: String?

    private enum CodingKeys: String, CodingKey {
        case id
        case title
        case posterPath = "poster_path"
        case releaseDate = "release_date"
    }
}
