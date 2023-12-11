import UIKit

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
}
