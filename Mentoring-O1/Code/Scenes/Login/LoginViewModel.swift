import SwiftUI

class LoginViewModel: ObservableObject {
    @Published var isLoading: Bool = false
    @Published var showingAlert = false
    @Published var email: String = ""
    @Published var password: String = ""
    @Published var errorMessage: String = ""

    private var interactor: LoginInteractor
    private var router: LoginRouter

    init(interactor: LoginInteractor, router: LoginRouter) {
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
    @MainActor 
    func loginResult(result: Result<Void, Error>) {
        hideLoading()
        switch result {
        case .success(()):
            self.router.showUpcomingScene()
        case .failure(let error):
            errorMessage = error.localizedDescription
        }
    }
}
