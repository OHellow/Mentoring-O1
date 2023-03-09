import Foundation

enum MoviesEndpoint {
    case topRated
    case movieDetail(id: Int)
    case upcomingMovies(page: Int)
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
        }
    }

    var method: RequestMethod {
        switch self {
        case .topRated, .movieDetail, .upcomingMovies:
            return .get
        }
    }

    var header: [String: String]? {
        let accessToken = ""
        switch self {
        case .topRated, .movieDetail, .upcomingMovies:
            return [
                "Authorization": "Bearer \(accessToken)",
                "Content-Type": "application/json;charset=utf-8"
            ]
        }
    }

    var body: [String: Any]? {
        switch self {
        case .topRated, .movieDetail, .upcomingMovies:
            return nil
        }
    }

    var params: [String: Any]? {
        switch self {
        case .upcomingMovies(let page):
            return ["page": page]
        case .topRated, .movieDetail:
            return nil
        }
    }
}
