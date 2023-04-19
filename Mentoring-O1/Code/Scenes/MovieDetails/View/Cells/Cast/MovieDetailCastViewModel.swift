import Foundation

final class MovieDetailCastViewModel {
    let name: String
    let profilePath: String?

    init(_ cast: Cast) {
        name = cast.name
        profilePath = cast.profilePath
    }
}
