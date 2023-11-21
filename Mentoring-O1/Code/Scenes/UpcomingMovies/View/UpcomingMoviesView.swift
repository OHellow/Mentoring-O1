import SwiftUI

struct UpcomingMoviesView: View {

    @ObservedObject var viewModel: UpcomingMoviesViewModel

    var body: some View {
        LazyVGrid(columns: Array(repeating: GridItem(), count: 3)) {
            ForEach(viewModel.movies) { movie in
                MovieCell(movie: movie, onTap: {
                    viewModel.navigateToMovieDetailsScene(uid: movie.id)
                })
            }
        }
        .navigationTitle("Upcoming Movies")
        .onAppear {
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
