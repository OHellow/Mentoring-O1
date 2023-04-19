import Foundation

final class MovieDetailRelatedViewModel {
    let title: String
    let posterPath: String?
    let releaseDate: String?

    init(_ relatedMovie: RelatedMovie) {
        title = relatedMovie.title
        posterPath = relatedMovie.posterPath
        releaseDate = relatedMovie.releaseDate
    }
}
