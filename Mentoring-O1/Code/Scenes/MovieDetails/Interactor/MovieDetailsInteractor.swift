import Foundation

final class MovieDetailsInteractor {
    var presenter: MovieDetailsPresenterInput?
    var networkWorker: MovieDetailsWorkerLogic?

    let relatedMoviesPage = 1
}

extension MovieDetailsInteractor: MoviewDetailsViewControllerInput {
    func fetchMovieDetails(id: Int?) {
        guard let id = id else { return }
        Task {
            async let details = networkWorker?.getMovieDetail(id: id)
            async let credits = networkWorker?.getMovieCredits(id: id)
            async let trailers = networkWorker?.getTrailersForMovie(id: id)
            async let relatedMovies = networkWorker?.getRelatedMovies(id: id, page: relatedMoviesPage)

            do {
                let result = try await (details?.get(), credits?.get(), trailers?.get(), relatedMovies?.get())
            } catch {

            }
        }
    }
}
