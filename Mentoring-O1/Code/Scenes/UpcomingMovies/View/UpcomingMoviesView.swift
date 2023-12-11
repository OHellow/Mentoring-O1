import SwiftUI

// swiftlint:disable all trailing_whitespace
struct UpcomingMoviesView: View {
    @ObservedObject var viewModel: UpcomingMoviesViewModel

    var body: some View {
        ScrollView {
            LazyVGrid(columns: Array(repeating: GridItem(.flexible(), spacing: 16), count: 2), spacing: 16) {
                ForEach(viewModel.movies) { movie in
                    let cellViewModel = UpcomingMovieCellViewModel(movie: movie) {
                        viewModel.navigateToMovieDetailsScene(uid: movie.id)
                    }
                    MovieCell(viewModel: cellViewModel)
                    .id(movie.id)
                    .onAppear {
                        if movie == viewModel.movies.last {
                            viewModel.showLoading()
                            viewModel.fetchMovies()
                        }
                    }
                    .frame(width: UIScreen.main.bounds.width * 0.4, height: UIScreen.main.bounds.height * 0.33)
                }
            }
            .padding()
        }
        .navigationTitle("Upcoming Movies")
        .task {
            viewModel.showLoading()
            viewModel.fetchMovies()
        }
    }
}

struct UpcomingMoviesView_Previews: PreviewProvider {
    static var previews: some View {
        let inter = UpcomingInteractor()
        let router = UpcomingMoviesRouter()
        let model = UpcomingMoviesViewModel(interactor: inter, router: router)
        UpcomingMoviesView(viewModel: model)
    }
}
