import UIKit

protocol MoviewDetailsViewControllerInput: AnyObject {
    func fetchMovieDetails(id: Int?)
    func getIdForRelatedMovie(at index: Int)
    func getAllCast()
}

protocol MoviewDetailsViewControllerOutput: AnyObject {
    func updateDetails(from movie: Movie)
    func updateCredits(from credits: MovieCredits)
    func updateTrailer(from trailer: Trailer)
    func updateRelatedMovies(from movies: [RelatedMovie])
    func navigateToAllCast(_ cast: [Cast])
    func navigateToRelatedMovie(id: Int)
    func showError(error: Error)
}

class MovieDetailsViewController: UIViewController, LoadingDisplayable {
    typealias CastDataSource = DefaultCollectionViewDataSource<MovieDetailsCastCell, Cast>
    typealias RelatedDataSource = DefaultCollectionViewDataSource<MovieDetailsRelatedCell, RelatedMovie>

    lazy var posterImageView: UIImageView = {
        let imageView = UIImageView()
        imageView.translatesAutoresizingMaskIntoConstraints = false
        return imageView
    }()

    lazy var titleLabel: UILabel = {
        let label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        label.font = .systemFont(ofSize: 24)
        label.textColor = UIColor(red: 0.749, green: 0.772, blue: 0.788, alpha: 1)
        label.numberOfLines = 2
        return label
    }()

    lazy var smallDetailsLabel: UILabel = {
        let label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        label.font = .systemFont(ofSize: 16)
        label.textColor = UIColor(red: 0.749, green: 0.773, blue: 0.788, alpha: 0.6)
        label.text = "7.8   NC-17   USA   2023   2h 49m"
        label.numberOfLines = 1
        return label
    }()

    lazy var genresTitleLabel: UILabel = {
        let label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        label.font = .systemFont(ofSize: 20)
        label.textColor = UIColor(red: 0.749, green: 0.772, blue: 0.788, alpha: 1)
        label.text = "Genres"
        label.numberOfLines = 1
        return label
    }()

    lazy var genresLabel: UILabel = {
        let label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        label.font = .systemFont(ofSize: 16)
        label.textColor = UIColor(red: 0.749, green: 0.772, blue: 0.788, alpha: 0.6)
        label.text = "Action   Crime   Triller"
        label.numberOfLines = 1
        return label
    }()

    var loaderView: LoadingViewProtocol = DefaultLoaderView()
    private let scrollView = UIScrollView()
    private let contentView = UIView()
    private var castView: ContentViewHorizontalCollection?
    private var relatedMoviesView: ContentViewHorizontalCollection?

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
        setupScrollView()
        setupPosterImageView()
        setupLabels()
        setupCastView()
        setupRelatedMoviesView()
        setupBackgroundGradient()
        interactor?.fetchMovieDetails(id: router?.dataStore?.id)
    }

    override func viewDidLayoutSubviews() {
        super.viewDidLayoutSubviews()
        scrollView.contentSize = contentView.bounds.size
    }

    private func setupBackgroundGradient() {
        let gradientLayer = CAGradientLayer()
        gradientLayer.colors = [UIColor(named: "colorBackgroundGradientStart")?.cgColor,
                                UIColor(named: "colorBackgroundGradientEnd")?.cgColor]
        gradientLayer.locations = [0.0, 1.0]
        gradientLayer.frame = view.bounds
        view.layer.insertSublayer(gradientLayer, at: 0)
    }

    private func setupScrollView() {
        view.addSubview(scrollView)
        scrollView.addSubview(contentView)
        scrollView.translatesAutoresizingMaskIntoConstraints = false
        contentView.translatesAutoresizingMaskIntoConstraints = false
        NSLayoutConstraint.activate([
            scrollView.topAnchor.constraint(equalTo: view.topAnchor),
            scrollView.centerXAnchor.constraint(equalTo: view.centerXAnchor),
            scrollView.widthAnchor.constraint(equalTo: view.widthAnchor),
            scrollView.bottomAnchor.constraint(equalTo: view.bottomAnchor),
            contentView.topAnchor.constraint(equalTo: scrollView.topAnchor),
            contentView.centerXAnchor.constraint(equalTo: scrollView.centerXAnchor),
            contentView.widthAnchor.constraint(equalTo: scrollView.widthAnchor),
            contentView.bottomAnchor.constraint(equalTo: scrollView.bottomAnchor)
        ])
    }

    private func setupPosterImageView() {
        contentView.addSubview(posterImageView)
        let navBarHeight = navigationController?.navigationBar.bounds.height ?? .zero
        NSLayoutConstraint.activate([
            posterImageView.topAnchor.constraint(equalTo: contentView.topAnchor, constant: -navBarHeight),
            posterImageView.leadingAnchor.constraint(equalTo: contentView.leadingAnchor),
            posterImageView.trailingAnchor.constraint(equalTo: contentView.trailingAnchor),
            posterImageView.heightAnchor.constraint(equalToConstant: UIScreen.main.bounds.height * 0.69)
        ])
        posterImageView.applyMovieDetailPosterGradient()
    }

    private func setupLabels() {
        contentView.addSubview(titleLabel)
        contentView.addSubview(smallDetailsLabel)
        contentView.addSubview(genresTitleLabel)
        contentView.addSubview(genresLabel)

        NSLayoutConstraint.activate([
            genresLabel.bottomAnchor.constraint(equalTo: posterImageView.bottomAnchor, constant: -8),
            genresLabel.leadingAnchor.constraint(equalTo: posterImageView.leadingAnchor, constant: 24),
            genresLabel.trailingAnchor.constraint(equalTo: posterImageView.trailingAnchor),
            genresTitleLabel.bottomAnchor.constraint(equalTo: genresLabel.topAnchor, constant: -12),
            genresTitleLabel.leadingAnchor.constraint(equalTo: genresLabel.leadingAnchor),
            genresTitleLabel.trailingAnchor.constraint(equalTo: posterImageView.trailingAnchor),
            smallDetailsLabel.bottomAnchor.constraint(equalTo: genresTitleLabel.topAnchor, constant: -42),
            smallDetailsLabel.leadingAnchor.constraint(equalTo: genresLabel.leadingAnchor),
            smallDetailsLabel.trailingAnchor.constraint(equalTo: posterImageView.trailingAnchor),
            titleLabel.bottomAnchor.constraint(equalTo: smallDetailsLabel.topAnchor, constant: -12),
            titleLabel.leadingAnchor.constraint(equalTo: genresLabel.leadingAnchor),
            titleLabel.trailingAnchor.constraint(equalTo: posterImageView.trailingAnchor)
        ])
    }

    private func setupCastView() {
        let collectionFlowLayout = HorizontalFlowLayout(cellHeight: 102, preferredWidth: 60)
        castView = ContentViewHorizontalCollection(title: "Cast",
                                                   isSeeAllLabelHidden: false,
                                                   collectionFlowLayout: collectionFlowLayout,
                                                   cellClass: MovieDetailsCastCell.self)
        guard let castView else { return }
        contentView.addSubview(castView)
        castView.translatesAutoresizingMaskIntoConstraints = false
        NSLayoutConstraint.activate([
            castView.topAnchor.constraint(equalTo: posterImageView.bottomAnchor, constant: 0),
            castView.leadingAnchor.constraint(equalTo: contentView.leadingAnchor),
            castView.trailingAnchor.constraint(equalTo: contentView.trailingAnchor),
            castView.heightAnchor.constraint(equalToConstant: 150)
        ])
    }

    private func setupRelatedMoviesView() {
        let collectionFlowLayout = HorizontalFlowLayout(cellHeight: 150, preferredWidth: 80)
        relatedMoviesView = ContentViewHorizontalCollection(title: "RelatedMovies",
                                                   isSeeAllLabelHidden: true,
                                                   collectionFlowLayout: collectionFlowLayout,
                                                   cellClass: MovieDetailsRelatedCell.self)
        guard let relatedMoviesView, let castView else { return }
        contentView.addSubview(relatedMoviesView)
        relatedMoviesView.translatesAutoresizingMaskIntoConstraints = false
        NSLayoutConstraint.activate([
            relatedMoviesView.topAnchor.constraint(equalTo: castView.bottomAnchor, constant: 40),
            relatedMoviesView.leadingAnchor.constraint(equalTo: contentView.leadingAnchor),
            relatedMoviesView.trailingAnchor.constraint(equalTo: contentView.trailingAnchor),
            relatedMoviesView.heightAnchor.constraint(equalToConstant: 180),
            relatedMoviesView.bottomAnchor.constraint(equalTo: contentView.bottomAnchor)
        ])
    }

    private func updateCastView(cast: [Cast]) {
        let dataSource: CastDataSource = DefaultCollectionViewDataSource(cellViewModels: cast,
                                                                         reuseIdentifier: MovieDetailsCastCell.reuseIdentifier,
                                                                         cellConfigurator: { cast, cell in
            cell.viewModel = MovieDetailCastViewModel(cast)
        })
        castView?.configureCollectionView(with: dataSource)
    }

    private func updateRelatedMoviesView(relatedMovies: [RelatedMovie]) {
        let dataSource: RelatedDataSource = DefaultCollectionViewDataSource(cellViewModels: relatedMovies,
                                                                            reuseIdentifier: MovieDetailsRelatedCell.reuseIdentifier,
                                                                            cellConfigurator: { relatedMovie, cell in
            cell.viewModel = MovieDetailRelatedViewModel(relatedMovie)
        })
        relatedMoviesView?.configureCollectionView(with: dataSource)
    }
}

extension MovieDetailsViewController: MoviewDetailsViewControllerOutput {
    func updateDetails(from movie: Movie) {
        if let posterPath = movie.posterPath {
            DispatchQueue.main.async {
                self.posterImageView.setImage(movieDBPathURL: posterPath)
                self.titleLabel.text = movie.title
            }
        }
    }

    func updateCredits(from credits: MovieCredits) {
        updateCastView(cast: credits.cast)
    }

    func updateTrailer(from trailer: Trailer) {}

    func updateRelatedMovies(from movies: [RelatedMovie]) {
        updateRelatedMoviesView(relatedMovies: movies)
    }

    func navigateToAllCast(_ cast: [Cast]) {
        router?.showAllCast(cast)
    }

    func navigateToRelatedMovie(id: Int) {
        router?.showRelatedMovie(id: id)
    }

    func showError(error: Error) {
        DispatchQueue.main.async {
            self.router?.showAlert(title: "Error", message: error.localizedDescription)
        }
    }
}

extension MovieDetailsViewController: ContentViewHorizontalCollectionDelegate {
    func didSelectItemAt(index: Int, cellClass: Reusable.Type?) {
        switch cellClass {
        case is MovieDetailsRelatedCell.Type:
            interactor?.getIdForRelatedMovie(at: index)
        default:
            break
        }
    }

    func didTapSeeAllLabel() {
        interactor?.getAllCast()
    }
}
