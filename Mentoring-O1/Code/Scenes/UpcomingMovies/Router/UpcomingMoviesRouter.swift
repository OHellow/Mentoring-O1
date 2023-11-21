import UIKit

protocol UpcomingRoutingLogic {
    func showDetails(movieId: Int)
}

class UpcomingMoviesRouter: UpcomingRoutingLogic {
    weak var viewController: UIViewController?

    func showDetails(movieId: Int) {
        let scene = ScreenFabricMovieDetails.makeDetailsScene(dataStore: MovieDetailDataStore(id: movieId))
        viewController?.navigationController?.pushViewController(scene, animated: true)
    }
}
