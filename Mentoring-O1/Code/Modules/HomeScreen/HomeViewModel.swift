import Foundation

class HomeViewModel: HomeViewModelProtocol {
    private var apiService: MoviesServiceable
    var movies: Observable<[Movie]> = Observable([])
    var error: Observable<RequestError?> = Observable(nil)

    init(apiService: MoviesServiceable) {
        self.apiService = apiService
        fetchMovies()
    }

    private func fetchMovies() {
        Task(priority: .background) {
            let results = await apiService.getTopRated()
            switch results {
            case .success(let results):
                self.movies.value = results.results
            case .failure(let error):
                self.error.value = error
            }
        }
    }
}

protocol HomeViewModelProtocol {
    var movies: Observable<[Movie]> { get  set }
    var error: Observable<RequestError?> { get set }
}
