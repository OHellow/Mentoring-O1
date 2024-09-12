import UIKit

final class ScreenFabricUpcomingMovies {
    static func makeUpcomingScene() -> UIViewController {
        let apiService = MovieClient()
        let interactor = UpcomingInteractor()
        let router = UpcomingMoviesRouter()
        let worker = UpcomingNetworkWorker(apiService: apiService)
        let errorWrapper = ErrorWrapper(error: "")
        let state = UpComingMoviesState()
        let model = UpcomingMoviesModel(interactor: interactor, router: router, state: state)
        let viewController = UpcomingViewController(model: model)

        interactor.networkWorker = worker
        router.viewController = viewController
        state.errorWrapper = errorWrapper
        return viewController
    }
}
