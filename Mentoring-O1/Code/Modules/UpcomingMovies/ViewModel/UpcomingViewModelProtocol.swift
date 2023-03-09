import Foundation

protocol UpcomingViewModelProtocol {
    var moviesResult: Observable<Result<[Movie], RequestError>?> { get set }
    var startLoading: Observable<Bool> { get set }

    func refreshMovies()
    func getMovies()
    func movie(for index: Int) -> Movie
    func getCellsCount() -> Int
}
