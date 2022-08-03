import UIKit

class HomeViewController: UIViewController {

    // MARK: Views
    private lazy var tableView: UITableView = {
        let tableView = UITableView()
        tableView.translatesAutoresizingMaskIntoConstraints = false
        return tableView
    }()

    // MARK: Properties
    private let viewModel: HomeViewModelProtocol
    private var dataSource: MoviesTableViewDataSource<TopRatedTableViewCell, Movie>?

    // MARK: LifeCycle
    init(viewModel: HomeViewModelProtocol) {
        self.viewModel = viewModel
        super.init(nibName: nil, bundle: nil)
    }

    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) is not supported")
    }

    override func viewDidLoad() {
        super.viewDidLoad()
        setupTableView()
        viewModel.movies.bind { movies in
            self.updateDataSource(movies: movies)
        }
        viewModel.error.bind { error in
            if let error = error {
                self.showModal(title: "Error", message: error.customMessage)
            }
        }
    }

    // MARK: Methods
    private func setupTableView() {
        view.addSubview(tableView)
        tableView.register(TopRatedTableViewCell.self, forCellReuseIdentifier: "TopRatedTableViewCell")
        tableView.leftAnchor.constraint(equalTo: view.leftAnchor).isActive = true
        tableView.topAnchor.constraint(equalTo: view.topAnchor).isActive = true
        tableView.rightAnchor.constraint(equalTo: view.rightAnchor).isActive = true
        tableView.bottomAnchor.constraint(equalTo: view.bottomAnchor).isActive = true
        tableView.rowHeight = 150
        tableView.delegate = self
    }

    private func updateDataSource(movies: [Movie]) {
        self.dataSource = MoviesTableViewDataSource(cellIdentifier: "TopRatedTableViewCell",
                                                    items: movies,
                                                    configureCell: { cell, movie in
            cell.configureCell(with: movie)
        })

        DispatchQueue.main.async {
            self.tableView.dataSource = self.dataSource
            self.tableView.reloadData()
        }
    }

    private func navigateToDetailsScreen(movieId: Int) {
    }

    private func showModal(title: String, message: String) {
        let alert = UIAlertController(title: title, message: message, preferredStyle: .alert)
        alert.addAction(UIAlertAction(title: "Ok", style: .default, handler: nil))
        self.present(alert, animated: true, completion: nil)
    }
}

// MARK: - TableView Methods
extension HomeViewController: UITableViewDelegate {
  func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
      tableView.deselectRow(at: indexPath, animated: true)
      if let movieId = dataSource?.getItem(at: indexPath.row).id {
          navigateToDetailsScreen(movieId: movieId)
      }
  }
}
