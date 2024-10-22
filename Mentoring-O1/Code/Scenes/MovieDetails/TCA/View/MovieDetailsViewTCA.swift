import SwiftUI
import ComposableArchitecture

struct MovieDetailsViewTCA: View {
    var store: StoreOf<MovieDetailsReducer>

    var body: some View {
        ScrollView {
            VStack {
                ZStack(alignment: .leading) {
                    AsyncImage(url: URL(string: store.movie.posterPath ?? ""))
                        .aspectRatio(contentMode: .fill)
                        .frame(height: Constants.posterImageHeightMultiplier)

                    VStack {
                        Spacer()
                        Text(store.movie.title)
                            .font(.system(size: 24))
                            .foregroundColor(.red)
                    }
                }
                Text("Genres")
                    .font(.system(size: 20))
                    .foregroundColor(Color(red: 0.749, green: 0.772, blue: 0.788, opacity: 1))
                    .padding(.top, -42)
                    .padding(.bottom, 12)

                Text("Action   Crime   Thriller")
                    .font(.system(size: 16))
                    .foregroundColor(Color(red: 0.749, green: 0.772, blue: 0.788, opacity: 0.6))
                    .multilineTextAlignment(.center)
                    .padding(.bottom, 20)

                VStack {
                    Text("Cast")
                    LazyHGrid(rows: Array(repeating: GridItem(.flexible(minimum: 100), spacing: 16), count: 1)) {
                        ForEach(store.movieCredits.cast) { item in
                            VStack {
                                AsyncImage(url: URL(string: item.profilePath ?? ""))
                                    .aspectRatio(contentMode: .fill)
                                    .frame(width: 32, height: 32)
                                Text(item.name)
                            }
                        }
                        .padding()
                    }
                }
                .padding()
                .background(LinearGradient(
                    gradient: Gradient(colors: [Color("colorBackgroundGradientStart"), Color("colorBackgroundGradientEnd")]),
                    startPoint: .top,
                    endPoint: .bottom
                ))
            }
            .navigationTitle(store.movie.title)
            .task {
                store.send(.fetchData)
            }
        }
    }
}
