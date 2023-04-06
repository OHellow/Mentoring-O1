import Foundation

struct MovieDetails: Decodable {
    let id: Int
    let title: String
    let genres: [Genre]?
    let adult: Bool?
    let overview: String
    let posterPath: String?
    let backdropPath: String?
    let releaseDate: String
    let voteAverage: Double?
    let voteCount: Int?
    let runtime: Int?

    private enum CodingKeys: String, CodingKey {
        case id
        case title
        case overview
        case adult
        case genres
        case runtime
        case posterPath = "poster_path"
        case backdropPath = "backdrop_path"
        case releaseDate = "release_date"
        case voteAverage = "vote_average"
        case voteCount = "vote_count"
    }
}
