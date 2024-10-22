import ComposableArchitecture

@Reducer
struct MovieDetailsReducer {
    @ObservableState
    struct State: Equatable {
        static func == (lhs: State, rhs: State) -> Bool {
            true
        }
        var movie: Movie
        var movieCredits: MovieCredits = .init(id: .zero, cast: [], crew: [])
        var movieTrailers: [Trailer] = []
        var relatedMovies: [RelatedMovie] = []
        var isLoading = false
        var isShowError = false
        var error: String = ""
    }

    enum Action {
        case fetchData
        case handleApiResults(movie: Result<Movie, RequestError>,
                              credits: Result<MovieCredits, RequestError>,
                              trailers: Result<TrailerResponse, RequestError>,
                              relatedMovies: Result<RelatedMoviesResponse, RequestError>)
        case hideError
    }

    var worker: MovieDetailsWorkerLogic

    var body: some ReducerOf<Self> {
        Reduce { state, action in
            switch action {
            case .fetchData:
                state.isLoading = true
                guard let movieId = state.movie.id else { return .none }
                return .run { send in
                    async let movieDetails = await worker.getMovieDetail(id: movieId)
                    async let movieCredits = await worker.getMovieCredits(id: movieId)
                    async let movieTrailers = await worker.getTrailersForMovie(id: movieId)
                    async let relatedMovies = await worker.getRelatedMovies(id: movieId, page: 1)

                    await send(.handleApiResults(
                        movie: await movieDetails,
                        credits: await movieCredits,
                        trailers: await movieTrailers,
                        relatedMovies: await relatedMovies
                    ))
                 }

            case .handleApiResults(let movieResult, let creditsResult, let trailersResult, let relatedMoviesResult):
                            state.isLoading = false

                            switch movieResult {
                            case .success(let movie):
                                state.movie = movie
                            case .failure(let error):
                                state.error = error.localizedDescription
                                state.isShowError = true
                            }

                            switch creditsResult {
                            case .success(let credits):
                                state.movieCredits = credits
                            case .failure(let error):
                                state.error = error.localizedDescription
                                state.isShowError = true
                            }

                            switch trailersResult {
                            case .success(let trailerResponse):
                                state.movieTrailers = trailerResponse.results
                            case .failure(let error):
                                state.error = error.localizedDescription
                                state.isShowError = true
                            }

                            switch relatedMoviesResult {
                            case .success(let relatedMoviesResponse):
                                state.relatedMovies = relatedMoviesResponse.results
                            case .failure(let error):
                                state.error = error.localizedDescription
                                state.isShowError = true
                            }

                            return .none
            case .hideError:
                state.isShowError = false
                return .none
            }
        }
    }
}
