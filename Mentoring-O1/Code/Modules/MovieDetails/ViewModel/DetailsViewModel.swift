import Foundation

final class DetailsViewModel: DetailsViewModelProtocol {
    private var apiService: MoviesServiceable
    //var genreName: Observable<String> = Observable("-")
    var requestError: Observable<RequestError?> = Observable(nil)
    var detailsModel: Observable<DetailsModel?> = Observable(nil)

    init(apiService: MoviesServiceable, movieId: Int) {
        self.apiService = apiService
        fetchMovies(movieId: movieId)
    }

    private func setup(movie: Movie) {
        detailsModel.value = DetailsModel(title: movie.title,
                                    releaseDate: movie.releaseDate,
                                    overview: movie.overview,
                                    voteAverage: movie.voteAverage,
                                    posterPath: movie.posterPath,
                                    backdropPath: movie.backdropPath)
        //getGenreName(genreId: movie.genreIDS?.first)
    }

    private func fetchMovies(movieId: Int) {
        Task(priority: .background) {
            let result = await apiService.getMovieDetail(id: movieId)
            switch result {
            case .success(let result):
                setup(movie: result)
            case .failure(let error):
                requestError.value = error
            }
        }
    }

//    private func getGenreName(genreId: Int) {
//        Task(priority: .background) {
//        }
//    }
}
