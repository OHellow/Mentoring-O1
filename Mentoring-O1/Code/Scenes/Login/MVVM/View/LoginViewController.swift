import UIKit
import SwiftUI

final class LoginViewController: UIViewController {
    var viewModel: LoginViewModel

    init(viewModel: LoginViewModel) {
        self.viewModel = viewModel
        super.init(nibName: nil, bundle: nil)
    }

    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

    override func viewDidLoad() {
        super.viewDidLoad()
        setupLoginView()
    }

    private func setupLoginView() {
        let loginView = LoginView(viewModel: viewModel)
        let loginViewContainer = UIHostingController(rootView: loginView)
        addChild(loginViewContainer)
        view.addSubview(loginViewContainer.view)
        loginViewContainer.view.translatesAutoresizingMaskIntoConstraints = false
        NSLayoutConstraint.activate([
            loginViewContainer.view.topAnchor.constraint(equalTo: view.topAnchor),
            loginViewContainer.view.leadingAnchor.constraint(equalTo: view.leadingAnchor),
            loginViewContainer.view.trailingAnchor.constraint(equalTo: view.trailingAnchor),
            loginViewContainer.view.bottomAnchor.constraint(equalTo: view.bottomAnchor)
        ])
        loginViewContainer.didMove(toParent: self)
    }
}
