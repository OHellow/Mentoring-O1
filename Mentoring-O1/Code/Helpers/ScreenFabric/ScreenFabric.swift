import UIKit

class ScreenFabric {
    static func makeHomeScreen() -> UIViewController {
        let apiService = MovieClient()
        let viewModel = UpcomingViewModel(apiService: apiService)
        let viewController = UpcomingViewController(viewModel: viewModel)
        return viewController
    }
}
