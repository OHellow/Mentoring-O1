import SwiftUI
import ComposableArchitecture

// swiftlint:disable all trailing_whitespace
struct UpcomingMoviesView: View {
    @EnvironmentObject private var model: UpcomingMoviesModel
    @EnvironmentObject var upcomingMoviesState: UpComingMoviesState

    var body: some View {
        ZStack {
            ScrollView {
                LazyVGrid(columns: Array(repeating: GridItem(.flexible(), spacing: 16), count: 2), spacing: 16) {
                    ForEach(model.movies) { movie in
                        let cellViewModel = UpcomingMovieCellViewModel(movie: movie) {
                            model.navigateToMovieDetailsScene(uid: movie.id)
                        }
                        MovieCell(viewModel: cellViewModel)
                            .id(movie.id)
                            .onAppear {
                                if movie == model.movies.last {
                                    model.fetchMovies()
                                }
                            }
                            .frame(width: UIScreen.main.bounds.width * 0.4, height: UIScreen.main.bounds.height * 0.33)
                    }
                }
                .padding()
            }
            if upcomingMoviesState.isLoading {
                VStack {
                    ProgressView("Logging in...")
                        .padding()
                        .background(RoundedRectangle(cornerRadius: 1).foregroundColor(Color.black.opacity(0.3)))
                }
            }
        }
        .navigationTitle("Upcoming Movies")
        .task {
            model.fetchMovies()
        }
        .sheet(item: $upcomingMoviesState.errorWrapper) { errorWrapper in
            ErrorView(errorDescription: errorWrapper.error)
        }
    }
}

struct UpcomingMoviesView_Previews: PreviewProvider {
    static var previews: some View {
        let inter = UpcomingInteractor()
        let router = UpcomingMoviesRouter()
        let state = UpComingMoviesState()
        let model = UpcomingMoviesModel(interactor: inter, router: router, state: state)
        UpcomingMoviesView()
            .environmentObject(model)
            .environmentObject(state)
    }
}
