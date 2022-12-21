import Foundation

protocol DetailsViewModelProtocol {
    var title: Observable<String> { get set }
    var overview: Observable<String> { get set }
    var requestError: Observable<RequestError?> { get set }
}

class DetailsViewModel: DetailsViewModelProtocol {
    private var apiService: MoviesServiceable
    var title: Observable<String> = Observable("")
    var overview: Observable<String> = Observable("")
    var requestError: Observable<RequestError?> = Observable(nil)

    init(apiService: MoviesServiceable, movieId: Int) {
        self.apiService = apiService
        fetchMovies(movieId: movieId)
    }

    private func fetchMovies(movieId: Int) {
        Task(priority: .background) {
            let result = await apiService.getMovieDetail(id: movieId)
            switch result {
            case .success(let result):
                parseMovieDetail(movie: result)
            case .failure(let error):
                self.requestError.value = error
            }
        }
    }

    private func parseMovieDetail(movie: Movie) {
        self.title.value = movie.title
        self.overview.value = movie.overview
    }
}
