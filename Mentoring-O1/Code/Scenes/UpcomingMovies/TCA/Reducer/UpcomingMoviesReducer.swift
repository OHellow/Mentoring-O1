import ComposableArchitecture
import NotificationCenter
import UserNotifications

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
        var error: String = ""
    }

    enum Action {
        case fetchMovies
        case handleFetchMoviesResponse(Result<MovieResult, RequestError>)
        case movieCellTapped(Movie)
        case scheduleNotification
        case hideError
    }

    var worker: UpcomingNetworkLogic
    var router: UpcomingRoutingLogic

    var body: some ReducerOf<Self> {
        Reduce { state, action in
            switch action {
            case .fetchMovies:
                state.isLoading = true
                let currentPage = state.currentPage
                UIApplication.shared.applicationIconBadgeNumber = 0
                UNUserNotificationCenter.current().removeAllDeliveredNotifications()
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
                }
                return .none

            case .movieCellTapped(let movie):
                router.showDetailsTCA(movie: movie)
                return .none

            case .scheduleNotification:
                let content = UNMutableNotificationContent()
                content.title = "Hello!"
                content.body = "This is a local notification."
                content.sound = .default

                let trigger = UNTimeIntervalNotificationTrigger(timeInterval: 5, repeats: false)

                let request = UNNotificationRequest(identifier: UUID().uuidString, content: content, trigger: trigger)

                UNUserNotificationCenter.current().add(request) { error in
                    if let error = error {
                        print("Error scheduling notification: \(error)")
                    }
                }
                return .none

            case .hideError:
                state.error = ""
                return .none
            }
        }
    }
}
