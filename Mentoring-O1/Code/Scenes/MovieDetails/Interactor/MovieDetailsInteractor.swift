import Foundation
import Combine

protocol MovieDetailsInteractorProtocol {
    func fetchMovieDetail(id: Int) -> AnyPublisher<Movie, RequestError>
    func fetchMovieCredits(id: Int) -> AnyPublisher<MovieCredits, RequestError>
    func fetchTrailersForMovie(id: Int) -> AnyPublisher<TrailerResponse, RequestError>
    func fetchRelatedMovies(id: Int, page: Int) -> AnyPublisher<RelatedMoviesResponse, RequestError>
}

final class MovieDetailsInteractor {
    var networkWorker: MovieDetailsWorkerLogic?
}

extension MovieDetailsInteractor: MovieDetailsInteractorProtocol {
    func fetchMovieDetail(id: Int) -> AnyPublisher<Movie, RequestError> {
        guard let networkWorker = self.networkWorker else {
            return Fail(error: RequestError.unknown).eraseToAnyPublisher()
        }

        return Future<Movie, RequestError> { promise in
            Task.detached {
                let movieDetail = await networkWorker.getMovieDetail(id: id)
                switch movieDetail {
                case .success(let movieDetail):
                    promise(.success(movieDetail))
                case .failure(let error):
                    promise(.failure(error))
                }
            }
        }
        .eraseToAnyPublisher()
    }

    func fetchMovieCredits(id: Int) -> AnyPublisher<MovieCredits, RequestError> {
        guard let networkWorker = self.networkWorker else {
            return Fail(error: RequestError.unknown).eraseToAnyPublisher()
        }

        return Future<MovieCredits, RequestError> { promise in
            Task.detached {
                let movieCredits = await networkWorker.getMovieCredits(id: id)
                switch movieCredits {
                case .success(let movieCredits):
                    promise(.success(movieCredits))
                case .failure(let error):
                    promise(.failure(error))
                }
            }
        }
        .eraseToAnyPublisher()
    }

    func fetchTrailersForMovie(id: Int) -> AnyPublisher<TrailerResponse, RequestError> {
        guard let networkWorker = self.networkWorker else {
            return Fail(error: RequestError.unknown).eraseToAnyPublisher()
        }

        return Future<TrailerResponse, RequestError> { promise in
            Task.detached {
                let movieTrailers = await networkWorker.getTrailersForMovie(id: id)
                switch movieTrailers {
                case .success(let movieTrailers):
                    promise(.success(movieTrailers))
                case .failure(let error):
                    promise(.failure(error))
                }
            }
        }
        .eraseToAnyPublisher()
    }

    func fetchRelatedMovies(id: Int, page: Int) -> AnyPublisher<RelatedMoviesResponse, RequestError> {
        guard let networkWorker = self.networkWorker else {
            return Fail(error: RequestError.unknown).eraseToAnyPublisher()
        }

        return Future<RelatedMoviesResponse, RequestError> { promise in
            Task.detached {
                let relatedMovies = await networkWorker.getRelatedMovies(id: id,
                                                                         page: page)
                switch relatedMovies {
                case .success(let relatedMovies):
                    promise(.success(relatedMovies))
                case .failure(let error):
                    promise(.failure(error))
                }
            }
        }
        .eraseToAnyPublisher()
    }
}
