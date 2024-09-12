import UIKit
import SwiftUI

final class UpcomingViewController: UIViewController {
    var model: UpcomingMoviesModel

    init(model: UpcomingMoviesModel) {
        self.model = model
        super.init(nibName: nil, bundle: nil)
    }

    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

    override func viewDidLoad() {
        super.viewDidLoad()
        setupUpcomingMoviesView()
    }

    private func setupUpcomingMoviesView() {
        let upcomingView = UpcomingMoviesView()
                           .environmentObject(model)
                           .environmentObject(model.upcomingMoviesSate)
        let upcomingViewContainer = UIHostingController(rootView: upcomingView)
        addChild(upcomingViewContainer)
        view.addSubview(upcomingViewContainer.view)
        upcomingViewContainer.view.translatesAutoresizingMaskIntoConstraints = false
        NSLayoutConstraint.activate([
            upcomingViewContainer.view.topAnchor.constraint(equalTo: view.topAnchor),
            upcomingViewContainer.view.leadingAnchor.constraint(equalTo: view.leadingAnchor),
            upcomingViewContainer.view.trailingAnchor.constraint(equalTo: view.trailingAnchor),
            upcomingViewContainer.view.bottomAnchor.constraint(equalTo: view.bottomAnchor)
        ])
        upcomingViewContainer.didMove(toParent: self)
    }
}
