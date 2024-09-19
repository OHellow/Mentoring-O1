import Foundation
import Combine

protocol UpcomingInteractorProtocol {
    func fetchMovies() -> AnyPublisher<[Movie], RequestError>
}

final class UpcomingInteractor {
    var networkWorker: UpcomingNetworkLogic?
    private var cancellables: Set<AnyCancellable> = []
    private var currentPage: Int = 1
}

extension UpcomingInteractor: UpcomingInteractorProtocol {
    func fetchMovies() -> AnyPublisher<[Movie], RequestError> {
        return Future<[Movie], RequestError> { [weak self] promise in
            guard let self = self else { return }
            Task(priority: .background) {
                let result = await self.networkWorker?.fetchMovies(page: self.currentPage)
                switch result {
                case .success(let results):
                    self.updatePage()
                    let movies = results.results
                    promise(.success(results.results))
                case .failure(let error):
                    promise(.failure(error))
                case .none:
                    break
                }
            }
        }
        .eraseToAnyPublisher()
    }

    private func updatePage() {
        self.currentPage += 1
    }
}
