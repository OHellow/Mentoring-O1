import UIKit
import ComposableArchitecture

final class ScreenFabricMovieDetails {
    static func makeDetailsScene(dataStore: MovieDetailDataStore) -> UIViewController {
        let apiService = MovieClient()
        let interactor = MovieDetailsInteractor()
        let router = MovieDetailsRouter()
        let worker = MovieDetailsWorker(apiService: apiService)
        let viewModel = MovieDetailsViewModel(movieId: dataStore.id, interactor: interactor, router: router)
        let viewController = MovieDetailsViewController(viewModel: viewModel)

        interactor.networkWorker = worker
        router.viewController = viewController
        router.dataStore = dataStore
        return viewController
    }

    static func makeMovieDetailsSceneTCA(movie: Movie) -> UIViewController {
        let store = Store(initialState: MovieDetailsReducer.State(movie: movie), reducer: {
            let apiService = MovieClient()
            let worker = MovieDetailsWorker(apiService: apiService)
            return MovieDetailsReducer(worker: worker)
        })
        let viewController = MovieDetailsViewControllerTCA(store: store)
        return viewController
    }
}
