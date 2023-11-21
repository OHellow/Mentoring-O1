import Foundation

protocol UpcomingInteractorDelegate: AnyObject {
    func fetchResult(result: Result<[Movie], RequestError>)
}

protocol UpcomingInteractorProtocol {
    func fetchMovies()
}

final class UpcomingInteractor {
    var networkWorker: UpcomingNetworkLogic?
    var delegate: UpcomingInteractorDelegate?
    var currentPage: Int = 1
}

extension UpcomingInteractor: UpcomingInteractorProtocol {
    func fetchMovies() {
        let page = currentPage + 1
        Task(priority: .background) {
            let result = await networkWorker?.fetchMovies(page: page)
            switch result {
            case .success(let results):
                updatePage()
                let movies = results.results
                delegate?.fetchResult(result: .success(movies))
            case .failure(let error):
                delegate?.fetchResult(result: .failure(error))
            case .none:
                break
            }
        }
    }

    private func updatePage() {
        self.currentPage += 1
    }
}
