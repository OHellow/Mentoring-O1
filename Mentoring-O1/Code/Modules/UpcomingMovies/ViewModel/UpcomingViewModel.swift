import Foundation

final class UpcomingViewModel: UpcomingViewModelProtocol {
    private var apiService: MoviesServiceable
    var movies: Observable<[Movie]> = Observable([])
    var error: Observable<RequestError?> = Observable(nil)
    var startLoading = Observable(false)
    var currentPage: Int = 1
    var isInitialPage = true

    init(apiService: MoviesServiceable) {
        self.apiService = apiService
        fetchMovies(page: 1)
    }

    func getCellsCount() -> Int {
        movies.value.count
    }

    func getMovies() {
        fetchMovies(page: currentPage, showLoading: isInitialPage)
    }

    func refreshMovies() {
        currentPage = 1
        fetchMovies(page: 1, showLoading: false)
    }

    func movie(for index: Int) -> Movie {
        return movies.value[index]
    }

    private func fetchMovies(page: Int, showLoading: Bool = false) {
        startLoading.value = showLoading
        Task(priority: .background) {
            startLoading.value = false
            let results = await apiService.getUpcomingMovies(page: page)
            print(results)
            switch results {
            case .success(let results):
                self.movies.value = processResults(results.results, currentPage: page)
            case .failure(let error):
                self.error.value = error
            }
        }
    }

    private func processResults(_ results: [Movie],
                                currentPage: Int) -> [Movie] {
        var allResults = currentPage == 1 ? [] : self.movies.value
        allResults.append(contentsOf: results)
        self.currentPage += 1
        return allResults
    }
}
