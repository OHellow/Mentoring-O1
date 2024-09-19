import ComposableArchitecture

@Reducer
struct UpcomingMoviesReducer {
    @ObservableState
    struct State: Equatable {
        static func == (lhs: State, rhs: State) -> Bool {
            true
        }
        var movies: [Movie] = []
        var currentPage: Int = 1
        var isLoading = false
        var isShowError = false
        var error: String = ""
    }

    enum Action {
        case fetchMovies
        case handleFetchMoviesResponse(Result<MovieResult, RequestError>)
        case movieCellTapped(Int)
        case hideError
    }

    var worker: UpcomingNetworkLogic

    var body: some ReducerOf<Self> {
        Reduce { state, action in
            switch action {
            case .fetchMovies:
                state.isLoading = true
                let currentPage = state.currentPage
                return .run { send in
                    let result = await worker.fetchMovies(page: currentPage)
                    await send(.handleFetchMoviesResponse(result))
                 }

            case .handleFetchMoviesResponse(let result):
                switch result {
                case .success(let result):
                    state.isLoading = false
                    state.movies.append(contentsOf: result.results)
                    state.currentPage += 1
                case .failure(let error):
                    state.isLoading = false
                    state.error = error.localizedDescription
                    state.isShowError = true
                }
                return .none

            case .movieCellTapped(let movieId):
                print("aaaaaaaa")
                return .none

            case .hideError:
                state.isShowError = false
                return .none
            }
        }
    }
}
