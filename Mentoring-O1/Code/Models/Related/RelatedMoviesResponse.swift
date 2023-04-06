import Foundation

struct RelatedMoviesResponse: Decodable {
    let page: Int
    let results: [RelatedMovie]
}
