import Foundation

protocol UpcomingNetworkLogic {
    func fetchMovies(page: Int) async -> Result<MovieResult, RequestError>
}

final class UpcomingNetworkWorker: UpcomingNetworkLogic {
    private let apiService: MoviesServiceable

    init(apiService: MoviesServiceable) {
        self.apiService = apiService
    }

    func fetchMovies(page: Int) async -> Result<MovieResult, RequestError> {
        return await apiService.getUpcomingMovies(page: page)
    }
}
