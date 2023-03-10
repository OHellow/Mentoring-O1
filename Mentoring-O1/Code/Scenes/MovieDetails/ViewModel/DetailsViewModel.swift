import Foundation

final class DetailsViewModel: DetailsViewModelProtocol {
    private var apiService: MoviesServiceable
    var detailsResult: Observable<Result<DetailsModel, RequestError>?> = Observable(nil)

    init(apiService: MoviesServiceable, movieId: Int) {
        self.apiService = apiService
        fetchMovies(movieId: movieId)
    }

    private func setup(movie: Movie) {
        detailsResult.value = .success(DetailsModel(title: movie.title,
                                                    releaseDate: movie.releaseDate,
                                                    overview: movie.overview,
                                                    voteAverage: movie.voteAverage,
                                                    posterPath: movie.posterPath,
                                                    backdropPath: movie.backdropPath))
    }

    private func fetchMovies(movieId: Int) {
        Task(priority: .background) {
            let result = await apiService.getMovieDetail(id: movieId)
            switch result {
            case .success(let result):
                setup(movie: result)
            case .failure(let error):
                detailsResult.value = .failure(error)
            }
        }
    }
}
