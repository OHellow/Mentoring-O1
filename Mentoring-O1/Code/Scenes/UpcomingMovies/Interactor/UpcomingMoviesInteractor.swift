import Foundation

protocol UpcomingInteractorOutput: AnyObject {
}

final class UpcomingInteractor {
    var presenter: UpcomingPresenterInput?
    var networkWorker: UpcomingNetworkLogic?

    var movies: [Movie]?
    var error: RequestError?
    var currentPage: Int = 1
    var isInitialPage = true
}

extension UpcomingInteractor: UpcomingViewControllerInput {
    func fetchMovies(page: Int? = nil) {
        let currentPage = (page != nil) ? page! : self.currentPage
        presenter?.showLoadingIndicator()
        Task(priority: .background) {
            presenter?.hideLoadingIndicator()
            let result = await networkWorker?.fetchMovies(page: currentPage)
            switch result {
            case .success(let results):
                let movies = processResults(results.results, currentPage: currentPage)
                self.movies = movies
                presenter?.updateMovies(with: movies)
            case .failure(let error):
                self.error = error
                presenter?.showError(error: error)
            case .none:
                break
            }
        }
    }

    func showDetail(at index: Int) {
        if let movieId = movies?[index].id {
            presenter?.showDetail(movieId: movieId)
        }
    }

    private func processResults(_ results: [Movie],
                                currentPage: Int) -> [Movie] {
        var allResults = currentPage == 1 ? [] : self.movies ?? []
        allResults.append(contentsOf: results)
        self.currentPage += 1
        return allResults
    }
}
