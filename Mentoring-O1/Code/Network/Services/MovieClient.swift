import Foundation

protocol MoviesServiceable {
    func getTopRated() async -> Result<TopRated, RequestError>
    func getMovieDetail(id: Int) async -> Result<Movie, RequestError>
    func getUpcomingMovies(page: Int) async -> Result<MovieResult, RequestError>
    func getMovieCredits(id: Int) async -> Result<MovieCredits, RequestError>
    func getTrailersForMovie(id: Int) async -> Result<TrailerResponse, RequestError>
    func getRelatedMovies(id: Int, page: Int) async -> Result<RelatedMoviesResponse, RequestError>
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

    func getMovieCredits(id: Int) async -> Result<MovieCredits, RequestError> {
        return await sendRequest(endpoint: MoviesEndpoint.movieCredits(id: id), responseModel: MovieCredits.self)
    }

    func getTrailersForMovie(id: Int) async -> Result<TrailerResponse, RequestError> {
        return await sendRequest(endpoint: MoviesEndpoint.movieTrailers(id: id), responseModel: TrailerResponse.self)
    }

    func getRelatedMovies(id: Int, page: Int) async -> Result<RelatedMoviesResponse, RequestError> {
        return await sendRequest(endpoint: MoviesEndpoint.relatedMovies(id: id,
                                                                        page: page),
                                 responseModel: RelatedMoviesResponse.self)
    }
}
