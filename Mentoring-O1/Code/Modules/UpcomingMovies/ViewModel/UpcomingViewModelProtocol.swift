import Foundation

protocol UpcomingViewModelProtocol {
    var movies: Observable<[Movie]> { get  set }
    var error: Observable<RequestError?> { get set }
    var startLoading: Observable<Bool> { get set }

    func refreshMovies()
    func getMovies()
    func movie(for index: Int) -> Movie
    func getCellsCount() -> Int
}
