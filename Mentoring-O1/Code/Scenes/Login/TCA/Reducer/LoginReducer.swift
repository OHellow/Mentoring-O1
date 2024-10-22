import ComposableArchitecture

@Reducer
struct LoginsReducer {
    @ObservableState
    struct State: Equatable {
        static func == (lhs: State, rhs: State) -> Bool {
            true
        }
        var email: String = ""
        var password: String = ""
        var isLoading = false
        var error: String = ""
    }

    enum Action {
        case onLoginButtonTapped
        case handleRequestTokenResult(Result<AuthResponse, RequestError>)
        case handleLoginResult(Result<AuthResponse, RequestError>)
        case hideError
    }

    var router: LoginRoutingLogic
    var worker: LoginNetworkWorker

    var body: some ReducerOf<Self> {
        Reduce { state, action in
            switch action {
            case .onLoginButtonTapped:
                state.isLoading = true
                return .run { send in
                    let result = await worker.requestToken()
                    await send(.handleRequestTokenResult(result))
                }

            case .handleRequestTokenResult(let result):
                switch result {
                    case .success(let tokenResult):
                    let email = state.email
                    let password = state.password
                    return .run { send in
                        let loginResult = await worker.logIn(email: email, password: password, token: tokenResult.requestToken ?? "")
                        await send(.handleLoginResult(loginResult))
                    }
                case .failure(let error):
                    state.error = error.localizedDescription
                    return .none
                }

            case .handleLoginResult(let result):
                switch result {
                    case .success:
                    router.showUpcomingScene()
                    return .none
                case .failure(let error):
                    state.error = error.localizedDescription
                    return .none
                }

            case .hideError:
                state.error = ""
                return .none
            }
        }
    }
}
