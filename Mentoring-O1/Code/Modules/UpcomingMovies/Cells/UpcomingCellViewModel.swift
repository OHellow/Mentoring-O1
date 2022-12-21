import Foundation

final class UpcomingCellViewModel: UpcomingCellViewModelProtocol {
    let title: String
    let releaseDate: String?
    let posterPath: String?

    init(_ movie: Movie) {
        title = movie.title
        releaseDate = movie.releaseDate
        posterPath = movie.posterPath
    }
}
