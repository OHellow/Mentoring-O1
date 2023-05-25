import UIKit

protocol UpcomingRoutingLogic {
    func showDetails(movieId: Int)
    func showAlert(title: String, message: String)
}

class UpcomingMoviesRouter: UpcomingRoutingLogic {
    weak var viewController: UIViewController?

    func showDetails(movieId: Int) {
        let scene = ScreenFabricMovieDetails.makeDetailsScene(dataStore: MovieDetailDataStore(id: movieId))
        viewController?.navigationController?.pushViewController(scene, animated: true)
    }

    func showAlert(title: String, message: String) {
        let alert = UIAlertController(title: title, message: message, preferredStyle: .alert)
        alert.addAction(UIAlertAction(title: "Ok", style: .default, handler: nil))
        viewController?.present(alert, animated: true)
    }
}
