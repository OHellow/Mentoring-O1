import Foundation

final class UpComingMoviesState: ObservableObject {
    @Published var isLoading = false
    @Published var errorWrapper: ErrorWrapper?
}

struct ErrorWrapper: Identifiable {
    let id = UUID()
    var error: String
}
