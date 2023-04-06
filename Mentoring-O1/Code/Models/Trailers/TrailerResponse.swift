import Foundation

struct TrailerResponse: Decodable {
    let id: Int
    let results: [Trailer]
}
