import SwiftUI

final class LoginViewModel: ObservableObject {
    @Published var isLoading: Bool = false
    @Published var showingAlert = false
    @Published var email: String = ""
    @Published var password: String = ""
    @Published var errorMessage: String = ""

    private var interactor: LoginInteractorProtocol
    private var router: LoginRoutingLogic

    init(interactor: LoginInteractorProtocol, router: LoginRoutingLogic) {
        self.interactor = interactor
        self.router = router
    }

    func loginAction() {
        interactor.didTapLogin(with: email, password: password)
    }

    @MainActor
    func showLoading() {
        isLoading = true
    }

    @MainActor
    func hideLoading() {
        isLoading = false
    }
}

extension LoginViewModel: LoginInteractorDelegate {
    @MainActor func loginResult(result: Result<Void, Error>) {
        hideLoading()
        switch result {
        case .success(()):
            self.router.showUpcomingScene()
        case .failure(let error):
            errorMessage = error.localizedDescription
        }
    }
}
