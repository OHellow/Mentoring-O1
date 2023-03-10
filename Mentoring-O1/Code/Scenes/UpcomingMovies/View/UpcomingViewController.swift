import UIKit

protocol UpcomingViewControllerInput: AnyObject {
    func fetchMovies(page: Int?)
    func showDetail(at: Int)
}

protocol UpcomingViewControllerOutput: AnyObject {
    func showDetailScene(with id: Int)
    func updateMovies(movies: [Movie])
    func showError(error: Error)
    func showLoading()
    func hideLoading()
}

final class UpcomingViewController: UIViewController, LoadingDisplayable, UICollectionViewDelegate {
    // MARK: Views
    private var collectionView: UICollectionView?
    var loaderView: LoadingViewProtocol = DefaultLoaderView()

    // MARK: Properties
    var interactor: UpcomingViewControllerInput?
    var router: UpcomingRoutingLogic?
    private var dataSource: DefaultCollectionViewDataSource<UpcomingCollectionViewCell, Movie>?
    private var prefetchedDataSource: CollectionViewPrefetchedDataSource?

    // MARK: LifeCycle
    override init(nibName nibNameOrNil: String?, bundle nibBundleOrNil: Bundle?) {
        super.init(nibName: nil, bundle: nil)
    }

    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) is not supported")
    }

    override func viewDidLoad() {
        super.viewDidLoad()
        setupCollectionView()
        interactor?.fetchMovies(page: 1)
    }

    // MARK: Methods
    private func setupCollectionView() {
        collectionView = UICollectionView(frame: self.view.frame, collectionViewLayout: self.setupCollectionViewLayout())

        collectionView?.delegate = self
        collectionView?.register(UpcomingCollectionViewCell.self,
                                 forCellWithReuseIdentifier: UpcomingCollectionViewCell.reuseIdentifier)
        view.addSubview(collectionView ?? UICollectionView())
    }

    private func setupRefreshControl() {
        collectionView?.refreshControl = DefaultRefreshControl(backgroundColor: collectionView?.backgroundColor,
                                                              refreshHandler: { [weak self] in
            self?.interactor?.fetchMovies(page: 1)
        })
    }

    private func setupCollectionViewLayout() -> UICollectionViewFlowLayout {
        let previewLayoutWidth = Constants.previewCellHeight / CGFloat(Constants.posterAspectRatio)
        let layout = VerticalFlowLayout(preferredWidth: previewLayoutWidth,
                                        preferredHeight: Constants.previewCellHeight,
                                        minColumns: Constants.previewLayoutMinColumns)

        return layout
    }

    private func updateDataSource(movies: [Movie]) {
        dataSource = DefaultCollectionViewDataSource(cellViewModels: movies,
                                                     reuseIdentifier: UpcomingCollectionViewCell.reuseIdentifier,
                                                     cellConfigurator: { movie, cell in
            cell.viewModel = UpcomingCellViewModel(movie)
        })

        prefetchedDataSource = CollectionViewPrefetchedDataSource(cellCount: movies.count,
                                                                  prefetchHandler: { [weak self] in
            self?.interactor?.fetchMovies(page: nil)
        })

        DispatchQueue.main.async {
            self.collectionView?.dataSource = self.dataSource
            self.collectionView?.prefetchDataSource = self.prefetchedDataSource
            self.collectionView?.reloadData()
        }
    }
}

// MARK: - TableView Methods
extension UpcomingViewController: UITableViewDelegate {
  func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
      tableView.deselectRow(at: indexPath, animated: true)
      interactor?.showDetail(at: indexPath.row)
  }
}

// MARK: - UpcomingViewControllerOutput
extension UpcomingViewController: UpcomingViewControllerOutput {
    func showDetailScene(with movieId: Int) {
        router?.showDetails(movieId: movieId)
    }

    func showLoading() {
        showLoader()
    }

    func hideLoading() {
        hideLoader()
    }

    func showError(error: Error) {
        DispatchQueue.main.async {
            self.router?.showAlert(title: "Error", message: error.localizedDescription)
        }
    }

    func updateMovies(movies: [Movie]) {
        updateDataSource(movies: movies)
    }
}

extension UpcomingViewController {
    struct Constants {
        static let previewCellHeight: CGFloat = 150.0
        static let detailCellHeight: CGFloat = 200.0
        static let detailCellOffset: CGFloat = 32.0
        static let previewLayoutMinColumns: Int = 3
        static let posterAspectRatio: Double = 1.5
    }
}
