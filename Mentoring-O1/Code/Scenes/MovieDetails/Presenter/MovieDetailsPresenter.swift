import Foundation

protocol MovieDetailsPresenterInput {
    func updateDetails(from movie: Movie?)
    func updateCredits(from credits: MovieCredits?)
    func updateTrailer(from trailer: Trailer?)
    func updateRelatedMovies(from movies: [RelatedMovie]?)
    func navigateToAllCast(_ cast: [Cast])
    func navigateToRelatedMovie(with id: Int)
    func showError(error: Error)
}

final class MovieDetailsPresenter: MovieDetailsPresenterInput {
    weak var viewController: MovieDetailsViewControllerOutput?

    func updateDetails(from movie: Movie?) {
        guard let movie = movie else { return }
        viewController?.updateDetails(from: movie)
    }

    func updateCredits(from credits: MovieCredits?) {
        guard let credits = credits else { return }
        viewController?.updateCredits(from: credits)
    }

    func updateTrailer(from trailer: Trailer?) {
        guard let trailer = trailer else { return }
        viewController?.updateTrailer(from: trailer)
    }

    func updateRelatedMovies(from movies: [RelatedMovie]?) {
        guard let movies = movies else { return }
        viewController?.updateRelatedMovies(from: movies)
    }

    func navigateToAllCast(_ cast: [Cast]) {
        viewController?.navigateToAllCast(cast)
    }

    func navigateToRelatedMovie(with id: Int) {
        viewController?.navigateToRelatedMovie(id: id)
    }

    func showError(error: Error) {
        viewController?.showError(error: error)
    }
}
