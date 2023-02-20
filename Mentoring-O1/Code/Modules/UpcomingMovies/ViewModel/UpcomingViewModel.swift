import Foundation

final class UpcomingViewModel: UpcomingViewModelProtocol {
    private var apiService: MoviesServiceable
    var moviesResult: Observable<Result<[Movie], RequestError>?> = Observable(nil)
    var startLoading = Observable(false)
    var currentPage: Int = 1
    var isInitialPage = true

    init(apiService: MoviesServiceable) {
        self.apiService = apiService
        fetchMovies(page: 1)
    }

    func getCellsCount() -> Int {
        switch moviesResult.value {
        case .success(let movies):
            return movies.count
        case .failure(_):
            return 0
        case .none:
            return 0
        }
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
            switch results {
            case .success(let results):
                self.moviesResult.value = .success(processResults(results.results, currentPage: page))
            case .failure(let error):
                self.moviesResult.value = .failure(error)
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
