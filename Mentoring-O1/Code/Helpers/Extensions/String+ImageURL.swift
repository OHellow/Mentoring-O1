import Foundation

extension String {
    func getImageURL() -> URL? {
        URL(string: "https://image.tmdb.org/t/p/w500\(self)")
    }
}
