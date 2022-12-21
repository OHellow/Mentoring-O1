import Foundation

protocol MoviesServiceable {
    func getTopRated() async -> Result<TopRated, RequestError>
    func getMovieDetail(id: Int) async -> Result<Movie, RequestError>
    func getUpcomingMovies(page: Int) async -> Result<MovieResult, RequestError>
}

struct MovieClient: APIClient, MoviesServiceable {
    func getUpcomingMovies(page: Int) async -> Result<MovieResult, RequestError> {
        return await sendRequest(endpoint: MoviesEndpoint.upcomingMovies(page: page), responseModel: MovieResult.self)
    }

    func getTopRated() async -> Result<TopRated, RequestError> {
        return await sendRequest(endpoint: MoviesEndpoint.topRated, responseModel: TopRated.self)
    }

    func getMovieDetail(id: Int) async -> Result<Movie, RequestError> {
        return await sendRequest(endpoint: MoviesEndpoint.movieDetail(id: id), responseModel: Movie.self)
    }
}
