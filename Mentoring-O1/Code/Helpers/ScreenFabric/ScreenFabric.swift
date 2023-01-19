import UIKit

class ScreenFabric {
    static func makeHomeScreen() -> UIViewController {
        let apiService = MovieClient()
        let viewModel = UpcomingViewModel(apiService: apiService)
        let viewController = UpcomingViewController(viewModel: viewModel)
        return viewController
    }

    static func makeDetailsScene(movieId: Int) -> UIViewController {
        let apiService = MovieClient()
        let viewModel = DetailsViewModel(apiService: apiService, movieId: movieId)
        let viewController = DetailsViewController(viewModel: viewModel)
        return viewController
    }
}
