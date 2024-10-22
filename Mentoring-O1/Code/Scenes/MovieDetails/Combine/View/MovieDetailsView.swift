import SwiftUI

struct MovieDetailsView: View {

    @ObservedObject var viewModel: MovieDetailsViewModel

    var body: some View {
        ScrollView {
            VStack {
                ZStack(alignment: .leading) {
                    Image("movie_poster")
                        .resizable()
                        .aspectRatio(contentMode: .fill)
                        .frame(height: Constants.posterImageHeightMultiplier)
                        .background(Color(.green))

                    VStack {
                        Spacer()
                        Text("Movie Title")
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
            }
            .padding()
            .background(LinearGradient(
                gradient: Gradient(colors: [Color("colorBackgroundGradientStart"), Color("colorBackgroundGradientEnd")]),
                startPoint: .top,
                endPoint: .bottom
            ))
        }
    }
}

struct ContentViewHorizontalCollectionUI: View {
    let title: String
    let isSeeAllLabelHidden: Bool

    var body: some View {
        VStack(alignment: .leading) {
            Text(title)
                .font(.system(size: 24))
                .foregroundColor(.primary)

            if !isSeeAllLabelHidden {
                Text("See All")
                    .font(.system(size: 16))
                    .foregroundColor(.accentColor)
            }
        }
    }
}

struct MovieDetailsView_Previews: PreviewProvider {
    static var previews: some View {
        let inter = MovieDetailsInteractor()
        let router = MovieDetailsRouter()
        let model = MovieDetailsViewModel(movieId: 111, interactor: inter, router: router)
        MovieDetailsView(viewModel: model)
    }
}

struct Constants {
    static let posterImageHeightMultiplier: CGFloat = UIScreen.main.bounds.height * 0.69
}
