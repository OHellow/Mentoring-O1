import Foundation

final class UpcomingMovieCellViewModel {
    var posterPath: URL?
    var title: String
    var releaseDate: String
    var onTap: () -> Void

    init(movie: Movie, onTap: @escaping () -> Void) {
        self.posterPath = movie.posterPath?.getImageURL()
        self.title = movie.title 
        self.releaseDate = movie.releaseDate ?? "N/A"
        self.onTap = onTap
    }
}
