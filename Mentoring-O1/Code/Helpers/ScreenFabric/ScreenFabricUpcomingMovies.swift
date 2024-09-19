import UIKit
import ComposableArchitecture

final class ScreenFabricUpcomingMovies {
//    static func makeUpcomingScene() -> UIViewController {
//        let apiService = MovieClient()
//        let interactor = UpcomingInteractor()
//        let router = UpcomingMoviesRouter()
//        let worker = UpcomingNetworkWorker(apiService: apiService)
//        let errorWrapper = ErrorWrapper(error: "")
//        let state = UpComingMoviesState()
//        let model = UpcomingMoviesModel(interactor: interactor, router: router, state: state)
//        let viewController = UpcomingViewController(model: model)
//
//        interactor.networkWorker = worker
//        router.viewController = viewController
//        state.errorWrapper = errorWrapper
//        return viewController
//    }

    static func makeUpcomingSceneTCA() -> UIViewController {
        let store = Store(initialState: UpcomingMoviesReducer.State()) {
            let apiService = MovieClient()
            let worker = UpcomingNetworkWorker(apiService: apiService)
            UpcomingMoviesReducer(worker: worker)
        }
        let viewController = UpcomingViewController(store: store)

        return viewController
    }
}
