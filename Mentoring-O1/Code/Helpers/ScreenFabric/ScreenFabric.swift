import UIKit

class ScreenFabric {
    static func makeUpcomingScene() -> UIViewController {
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

    static func makeLoginScene() -> UIViewController {
        let apiService = AuthClient()
        let viewModel = LoginViewModel(apiService: apiService)
        let viewController = LoginViewController(viewModel: viewModel)
        return viewController
    }
}
