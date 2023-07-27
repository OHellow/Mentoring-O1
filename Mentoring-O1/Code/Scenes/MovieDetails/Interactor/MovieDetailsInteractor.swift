import Foundation

final class MovieDetailsInteractor {
    var presenter: MovieDetailsPresenterInput?
    var networkWorker: MovieDetailsWorkerLogic?
    var relatedMovies: [RelatedMovie] = []
    var movieCast: [Cast] = []
    let relatedMoviesPage = 1
}

extension MovieDetailsInteractor: MoviewDetailsViewControllerInput {
    func fetchMovieDetails(id: Int?) {
        guard let id = id else { return }
        Task {
            let taskResults = await fetchData(id: id, page: relatedMoviesPage)

            for taskResult in taskResults {
                switch taskResult {
                case .movieDetails(let movieDetails):
                    presenter?.updateDetails(from: movieDetails)
                case .movieCredits(let movieCredits):
                    self.movieCast = movieCredits.cast
                    presenter?.updateCredits(from: movieCredits)
                case .movieTrailers(let movieTrailers):
                    presenter?.updateTrailer(from: movieTrailers.results.first)
                case .movieRalatedMovies(let relatedMovies):
                    self.relatedMovies = relatedMovies.results
                    presenter?.updateRelatedMovies(from: relatedMovies.results)
                case .requestError(let error):
                    presenter?.showError(error: error)
                }
            }
        }
    }

    func getAllCast() {
        let cast = movieCast
        presenter?.navigateToAllCast(cast)
    }

    func getIdForRelatedMovie(at index: Int) {
        let relatedMovieId = relatedMovies[index].id
        presenter?.navigateToRelatedMovie(with: relatedMovieId)
    }

    // swiftlint:disable:next function_body_length
    func fetchData(id: Int, page: Int) async -> [TaskResult] {
        return await withTaskGroup(of: TaskResult.self) { [weak self] group in
            guard let networkWorker = self?.networkWorker else { return [TaskResult.requestError(.unknown)] }
            group.addTask {
                let movieDetail = await networkWorker.getMovieDetail(id: id)
                switch movieDetail {
                case .success(let movieDetail):
                    return TaskResult.movieDetails(movieDetail)
                case .failure(let error):
                    return TaskResult.requestError(error)
                }
            }
            group.addTask {
                let movieCredits = await networkWorker.getMovieCredits(id: id)
                switch movieCredits {
                case .success(let movieCredits):
                    return TaskResult.movieCredits(movieCredits)
                case .failure(let error):
                    return TaskResult.requestError(error)
                }
            }
            group.addTask {
                let movieTrailers = await networkWorker.getTrailersForMovie(id: id)
                switch movieTrailers {
                case .success(let movieTrailers):
                    return TaskResult.movieTrailers(movieTrailers)
                case .failure(let error):
                    return TaskResult.requestError(error)
                }
            }
            group.addTask {
                let relatedMovies = await networkWorker.getRelatedMovies(id: id,
                                                                         page: page)
                switch relatedMovies {
                case .success(let relatedMovies):
                    return TaskResult.movieRalatedMovies(relatedMovies)
                case .failure(let error):
                    return TaskResult.requestError(error)
                }
            }

            var results = [TaskResult]()
            for await result in group {
                results.append(result)
            }
            return results
        }
    }

    enum TaskResult {
        case movieDetails(Movie)
        case movieCredits(MovieCredits)
        case movieTrailers(TrailerResponse)
        case movieRalatedMovies(RelatedMoviesResponse)
        case requestError(RequestError)
    }
}
