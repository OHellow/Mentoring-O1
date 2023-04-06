import UIKit

protocol MovieDetailsRoutingLogic {
    func showRelatedMovie(id: Int)
    func showAllCast(_: [Cast])
    func showAlert(title: String, message: String)
}

protocol MovieDetailsPassing {
    var dataStore: MovieDetailDataStore? { get set }
}

class MovieDetailsRouter: MovieDetailsRoutingLogic, MovieDetailsPassing {
    weak var viewController: UIViewController?
    var dataStore: MovieDetailDataStore?

    func showRelatedMovie(id: Int) {

    }

    func showAllCast(_: [Cast]) {
        
    }

    func showAlert(title: String, message: String) {
        let alert = UIAlertController(title: title, message: message, preferredStyle: .alert)
        alert.addAction(UIAlertAction(title: "Ok", style: .default, handler: nil))
        viewController?.present(alert, animated: true)
    }
}

struct MovieDetailDataStore {
    let id: Int
}
