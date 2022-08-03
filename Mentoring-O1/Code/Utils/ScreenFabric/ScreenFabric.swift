import Foundation
import UIKit

class ScreenFabric {
    static func makeHomeScreen() -> UIViewController {
        let apiService = MoviesService()
        let viewModel = HomeViewModel(apiService: apiService)
        let viewController = HomeViewController(viewModel: viewModel)
        return viewController
    }
}
