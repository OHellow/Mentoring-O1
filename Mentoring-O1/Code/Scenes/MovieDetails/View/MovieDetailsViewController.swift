import UIKit

protocol MoviewDetailsViewControllerInput: AnyObject {
    func fetchMovieDetails(id: Int?)
}

protocol MoviewDetailsViewControllerOutput: AnyObject {
    func showError(error: Error)
    func updateDetails(from movie: Movie)
    func updateCredits(from credits: MovieCredits)
    func updateTrailer(from trailer: Trailer)
    func updateRelatedMovies(from movies: [RelatedMovie])
}

class MovieDetailsViewController: UIViewController, LoadingDisplayable {
    private let kTitleFontSize: CGFloat = 18

    lazy var posterImageView: UIImageView = {
        let imageView = UIImageView()
        imageView.translatesAutoresizingMaskIntoConstraints = false
        return imageView
    }()

    lazy var titleLabel: UILabel = {
        let label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        label.font = .systemFont(ofSize: kTitleFontSize, weight: .semibold)
        return label
    }()

    lazy var overviewLabel: UILabel = {
        let label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        label.numberOfLines = .zero
        return label
    }()

    var loaderView: LoadingViewProtocol = DefaultLoaderView()

    var interactor: MoviewDetailsViewControllerInput?
    var router: (MovieDetailsRoutingLogic & MovieDetailsPassing)?

    override init(nibName nibNameOrNil: String?, bundle nibBundleOrNil: Bundle?) {
        super.init(nibName: nil, bundle: nil)
    }

    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) is not supported")
    }

    override func viewDidLoad() {
        super.viewDidLoad()
        interactor?.fetchMovieDetails(id: router?.dataStore?.id)
    }
}

extension MovieDetailsViewController: MoviewDetailsViewControllerOutput {
    func updateDetails(from movie: Movie) {}

    func updateCredits(from credits: MovieCredits) {}

    func updateTrailer(from trailer: Trailer) {}

    func updateRelatedMovies(from movies: [RelatedMovie]) {}

    func showError(error: Error) {
        DispatchQueue.main.async {
            self.router?.showAlert(title: "Error", message: error.localizedDescription)
        }
    }
}
