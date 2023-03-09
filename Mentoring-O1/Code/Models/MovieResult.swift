import Foundation

struct MovieResult: Decodable, Paginable {
    let results: [Movie]
    var currentPage: Int
    var totalPages: Int

    private enum CodingKeys: String, CodingKey {
        case results
        case currentPage = "page"
        case totalPages = "total_pages"
    }
}
