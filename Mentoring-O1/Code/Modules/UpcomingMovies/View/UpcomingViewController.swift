import UIKit

final class UpcomingViewController: UIViewController, LoadingDisplayable, UICollectionViewDelegate {
    // MARK: Views
    private var collectionView: UICollectionView?
    var loaderView: LoadingViewProtocol = DefaultLoaderView()

    // MARK: Properties
    private let viewModel: UpcomingViewModelProtocol
    private var dataSource: DefaultCollectionViewDataSource<UpcomingCollectionViewCell, Movie>?
    private var prefetchedDataSource: CollectionViewPrefetchedDataSource?

    // MARK: LifeCycle
    init(viewModel: UpcomingViewModelProtocol) {
        self.viewModel = viewModel
        super.init(nibName: nil, bundle: nil)
    }

    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) is not supported")
    }

    override func viewDidLoad() {
        super.viewDidLoad()
        setupCollectionView()
        setupBindables()
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
            self?.viewModel.refreshMovies()
        })
    }

    private func setupCollectionViewLayout() -> UICollectionViewFlowLayout {
        let previewLayoutWidth = Constants.previewCellHeight / CGFloat(Constants.posterAspectRatio)
        let layout = VerticalFlowLayout(preferredWidth: previewLayoutWidth,
                                        preferredHeight: Constants.previewCellHeight,
                                        minColumns: Constants.previewLayoutMinColumns)

        return layout
    }

    private func setupBindables() {
        viewModel.moviesResult.bind { [weak self] result in
            guard let self else { return }
            switch result {
            case .success(let movies):
                self.updateDataSource(movies: movies)
            case .failure(let error):
                DispatchQueue.main.async {
                    self.showModal(title: "Error", message: error.localizedDescription)
                }
            case .none:
                break
            }
        }
        viewModel.startLoading.bind { [weak self] startLoading in
            guard let self else { return }
            startLoading ? self.showLoader() : self.hideLoader()
        }
    }

    private func updateDataSource(movies: [Movie]) {
        dataSource = DefaultCollectionViewDataSource(cellViewModels: movies,
                                                          reuseIdentifier: UpcomingCollectionViewCell.reuseIdentifier,
                                                          cellConfigurator: { movie, cell in
            cell.viewModel = UpcomingCellViewModel(movie)
        })

        prefetchedDataSource = CollectionViewPrefetchedDataSource(cellCount: viewModel.getCellsCount(),
                                                                   prefetchHandler: { [weak self] in
            self?.viewModel.getMovies()
        })

        DispatchQueue.main.async {
            self.collectionView?.dataSource = self.dataSource
            self.collectionView?.prefetchDataSource = self.prefetchedDataSource
            self.collectionView?.reloadData()
        }
    }

    private func navigateToDetailsScreen(movieId: Int) {
        let viewController = ScreenFabric.makeDetailsScene(movieId: movieId)
        navigationController?.pushViewController(viewController, animated: true)
    }

    private func showModal(title: String, message: String) {
        let alert = UIAlertController(title: title, message: message, preferredStyle: .alert)
        alert.addAction(UIAlertAction(title: "Ok", style: .default, handler: nil))
        self.present(alert, animated: true, completion: nil)
    }
}

// MARK: - TableView Methods
extension UpcomingViewController: UITableViewDelegate {
  func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
      tableView.deselectRow(at: indexPath, animated: true)
      if let movieId = dataSource?.getItem(at: indexPath.row).id {
          navigateToDetailsScreen(movieId: movieId)
      }
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
