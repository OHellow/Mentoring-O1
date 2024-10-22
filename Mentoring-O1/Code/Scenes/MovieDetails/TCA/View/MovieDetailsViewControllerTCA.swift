import SwiftUI
import UIKit
import ComposableArchitecture

final class MovieDetailsViewControllerTCA: UIViewController {
    var store: StoreOf<MovieDetailsReducer>

    init(store: StoreOf<MovieDetailsReducer>) {
        self.store = store
        super.init(nibName: nil, bundle: nil)
    }

    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

    override func viewDidLoad() {
        super.viewDidLoad()
        setupMovieDetailsView()
    }

    private func setupMovieDetailsView() {
        let movieDetailsView = MovieDetailsViewTCA(store: store)
        let movieDetailsViewContainer = UIHostingController(rootView: movieDetailsView)
        addChild(movieDetailsViewContainer)
        view.addSubview(movieDetailsViewContainer.view)
        movieDetailsViewContainer.view.translatesAutoresizingMaskIntoConstraints = false
        NSLayoutConstraint.activate([
            movieDetailsViewContainer.view.topAnchor.constraint(equalTo: view.topAnchor),
            movieDetailsViewContainer.view.leadingAnchor.constraint(equalTo: view.leadingAnchor),
            movieDetailsViewContainer.view.trailingAnchor.constraint(equalTo: view.trailingAnchor),
            movieDetailsViewContainer.view.bottomAnchor.constraint(equalTo: view.bottomAnchor)
        ])
        movieDetailsViewContainer.didMove(toParent: self)
    }
}
