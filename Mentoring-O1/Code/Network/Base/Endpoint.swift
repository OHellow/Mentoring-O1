import Foundation

protocol Endpoint {
    var scheme: String { get }
    var host: String { get }
    var path: String { get }
    var method: RequestMethod { get }
    var header: [String: String]? { get }
    var body: [String: Any]? { get }
    var params: [String: Any]? { get }
}

extension Endpoint {
    var baseURL: String {
        "https://api.themoviedb.org"
    }
    var apiKey: String {
        return "a122e1727b06b2c9f0d6dba1d231ed38"
    }

    var scheme: String {
        return "https"
    }

    var host: String {
        return "api.themoviedb.org"
    }

    var urlComponents: URLComponents {
        var components = URLComponents()
        components.scheme = scheme
        components.host = host
        components.path = path
        var queryItems = [URLQueryItem(name: "api_key", value: apiKey)]
                          //URLQueryItem(name: "language", value: "en-US")]
        if let params = params, method == .get {
            queryItems.append(contentsOf: params.map {
                return URLQueryItem(name: "\($0)", value: "\($1)")
            })
        }
        components.queryItems = queryItems
        print(components.url)
        return components
    }
}
