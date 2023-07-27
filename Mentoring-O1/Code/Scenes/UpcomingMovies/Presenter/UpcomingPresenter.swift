import Foundation

protocol UpcomingPresenterInput {
    func showDetail(movieId: Int)
    func updateMovies(with movies: [Movie])
    func showError(error: Error)
    func showLoadingIndicator()
    func hideLoadingIndicator()
}

final class UpcomingPresenter: UpcomingPresenterInput {
    weak var viewController: UpcomingViewControllerOutput?

    func showDetail(movieId: Int) {
        viewController?.showDetailScene(with: movieId)
    }

    func updateMovies(with movies: [Movie]) {
        viewController?.updateMovies(movies: movies)
    }

    func showError(error: Error) {
        viewController?.showError(error: error)
    }

    func showLoadingIndicator() {
        viewController?.showLoading()
    }

    func hideLoadingIndicator() {
        viewController?.hideLoading()
    }
}
