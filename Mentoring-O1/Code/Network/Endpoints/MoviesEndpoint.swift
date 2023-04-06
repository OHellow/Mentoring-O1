import Foundation

enum MoviesEndpoint {
    case topRated
    case movieDetail(id: Int)
    case upcomingMovies(page: Int)
    case movieCredits(id: Int)
    case movieTrailers(id: Int)
    case relatedMovies(id: Int, page: Int)
}

extension MoviesEndpoint: Endpoint {
    var path: String {
        switch self {
        case .topRated:
            return "/3/movie/top_rated"
        case .movieDetail(let id):
            return "/3/movie/\(id)"
        case .upcomingMovies:
            return "/3/movie/upcoming"
        case .movieCredits(let id):
            return "/3/movie/\(id)/credits"
        case .movieTrailers(let id):
            return "/3/movie/\(id)/videos"
        case .relatedMovies(let id, _):
            return "/3/movie/\(id)/recommendations"
        }
    }

    var method: RequestMethod {
        switch self {
        case .topRated, .movieDetail, .upcomingMovies, .movieCredits, .movieTrailers, .relatedMovies:
            return .get
        }
    }

    var header: [String: String]? {
        let accessToken = ""
        switch self {
        case .topRated, .movieDetail, .upcomingMovies, .movieCredits, .movieTrailers, .relatedMovies:
            return [
                "Authorization": "Bearer \(accessToken)",
                "Content-Type": "application/json;charset=utf-8"
            ]
        }
    }

    var body: [String: Any]? {
        switch self {
        case .topRated, .movieDetail, .upcomingMovies, .movieCredits, .movieTrailers, .relatedMovies:
            return nil
        }
    }

    var params: [String: Any]? {
        switch self {
        case .upcomingMovies(let page):
            return ["page": page]
        case .relatedMovies( _, let page):
            return ["page": page]
        case .topRated, .movieDetail, .movieCredits, .movieTrailers:
            return nil
        }
    }
}
