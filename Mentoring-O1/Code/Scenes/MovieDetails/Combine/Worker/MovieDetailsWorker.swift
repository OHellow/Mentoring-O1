import Foundation

protocol MovieDetailsWorkerLogic {
    func getMovieDetail(id: Int) async -> Result<Movie, RequestError>
    func getMovieCredits(id: Int) async -> Result<MovieCredits, RequestError>
    func getTrailersForMovie(id: Int) async -> Result<TrailerResponse, RequestError>
    func getRelatedMovies(id: Int, page: Int) async -> Result<RelatedMoviesResponse, RequestError>
}

final class MovieDetailsWorker: MovieDetailsWorkerLogic {
    private let apiService: MoviesServiceable

    init(apiService: MoviesServiceable) {
        self.apiService = apiService
    }

    func getMovieDetail(id: Int) async -> Result<Movie, RequestError> {
        return await apiService.getMovieDetail(id: id)
    }

    func getMovieCredits(id: Int) async -> Result<MovieCredits, RequestError> {
        return await apiService.getMovieCredits(id: id)
    }

    func getTrailersForMovie(id: Int) async -> Result<TrailerResponse, RequestError> {
        return await apiService.getTrailersForMovie(id: id)
    }

    func getRelatedMovies(id: Int, page: Int) async -> Result<RelatedMoviesResponse, RequestError> {
        return await apiService.getRelatedMovies(id: id, page: page)
    }
}
