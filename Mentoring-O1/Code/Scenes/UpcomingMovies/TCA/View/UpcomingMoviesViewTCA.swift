import SwiftUI
import ComposableArchitecture

struct UpcomingMoviesViewTCA: View {
    var store: StoreOf<UpcomingMoviesReducer>

    var body: some View {
        ZStack {
            ScrollView {
                LazyVGrid(columns: Array(repeating: GridItem(.flexible(), spacing: 16), count: 2), spacing: 16) {
                    ForEach(store.movies) { movie in
                        let cellViewModel = UpcomingMovieCellViewModel(movie: movie) {
                            store.send(.movieCellTapped(movie.id ?? .zero))
                        }
                        MovieCell(viewModel: cellViewModel)
                            .id(movie.id)
                            .onAppear {
                                if movie == store.movies.last {
                                    store.send(.fetchMovies)
                                }
                            }
                            .frame(width: UIScreen.main.bounds.width * 0.4, height: UIScreen.main.bounds.height * 0.33)
                    }
                }
                .padding()
            }
            if store.isLoading {
                ProgressView()
                    .progressViewStyle(CircularProgressViewStyle())
                    .scaleEffect(2)
            }
            if store.isShowError {
                DefaultAlertView(title: "Error", message: store.error) {
                    store.send(.hideError)
                }
            }
        }
        .navigationTitle("Upcoming Movies")
        .task {
            store.send(.fetchMovies)
        }
    }
}

#Preview {
    UpcomingMoviesViewTCA(
        store: Store(initialState: UpcomingMoviesReducer.State()) {
            let apiService = MovieClient()
            let worker = UpcomingNetworkWorker(apiService: apiService)
            let reducer = UpcomingMoviesReducer(worker: worker)
            return reducer
    }
    )
}
