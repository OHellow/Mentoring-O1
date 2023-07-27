import UIKit

final class ScreenFabricMovieDetails {
    static func makeDetailsScene(dataStore: MovieDetailDataStore) -> UIViewController {
        let apiService = MovieClient()
        let presenter = MovieDetailsPresenter()
        let interactor = MovieDetailsInteractor()
        let router = MovieDetailsRouter()
        let worker = MovieDetailsWorker(apiService: apiService)
        let viewController = MovieDetailsViewController()

        interactor.presenter = presenter
        interactor.networkWorker = worker
        presenter.viewController = viewController
        viewController.interactor = interactor
        viewController.router = router
        router.viewController = viewController
        router.dataStore = dataStore
        return viewController
    }
}
