import UIKit

protocol MovieDetailsRoutingLogic {
    func showRelatedMovie(id: Int)
    func showAllCast(_: [Cast])
}

protocol MovieDetailsPassing {
    var dataStore: MovieDetailDataStore? { get set }
}

class MovieDetailsRouter: MovieDetailsRoutingLogic, MovieDetailsPassing {
    weak var viewController: UIViewController?
    var dataStore: MovieDetailDataStore?

    func showRelatedMovie(id: Int) {
        let scene = ScreenFabricMovieDetails.makeDetailsScene(dataStore: MovieDetailDataStore(id: id))
        viewController?.navigationController?.pushViewController(scene, animated: true)
    }

    func showAllCast(_: [Cast]) {}
}

struct MovieDetailDataStore {
    let id: Int
}
