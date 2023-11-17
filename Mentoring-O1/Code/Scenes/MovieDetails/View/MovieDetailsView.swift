import SwiftUI

struct MovieDetailsView: View {
    var body: some View {
        ScrollView {
            VStack {
                // Poster Image View
                ZStack(alignment: .leading) {
                    Image("movie_poster")
                        .resizable()
                        .aspectRatio(contentMode: .fill)
                        .frame(height: Constants.posterImageHeightMultiplier)
                        .background(Color(.green))
                        //.padding(.leading, 16)
                        //.padding(.bottom, 16)

                    VStack {
                        Spacer()
                        Text("Movie Title")
                        .font(.system(size: 24))
                        .foregroundColor(.red)
                    }
                        //.padding(.leading, 10)

//                    VStack(alignment: .leading, spacing: 16) {
//                        Spacer()
//
//
////                        Text("7.8   NC-17   USA   2023   2h 49m")
////                            .font(.system(size: 16))
////                            .foregroundColor(Color(red: 0.749, green: 0.773, blue: 0.788, opacity: 0.6))
////                            .padding(.leading, 12)
////                            .padding(.bottom)
//                    }
////                    .alignmentGuide(.leading) { _ in 0 }
////                    .padding(.leading, 16)
////                    .padding(.bottom, 16)
//                    .background()
                }
                // Genres Title Label
                Text("Genres")
                    .font(.system(size: 20))
                    .foregroundColor(Color(red: 0.749, green: 0.772, blue: 0.788, opacity: 1))
                    .padding(.top, -42)
                    .padding(.bottom, 12)

                // Genres Label
                Text("Action   Crime   Thriller")
                    .font(.system(size: 16))
                    .foregroundColor(Color(red: 0.749, green: 0.772, blue: 0.788, opacity: 0.6))
                    .multilineTextAlignment(.center)
                    .padding(.bottom, 20)

                // Cast View
                ContentViewHorizontalCollectionUI(title: "Cast", isSeeAllLabelHidden: false)

                // Related Movies View
                ContentViewHorizontalCollectionUI(title: "Related Movies", isSeeAllLabelHidden: true)
                    .padding(.top, 20)
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

            // Add your horizontal collection view here

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
        MovieDetailsView()
    }
}

struct Constants {
    static let posterImageHeightMultiplier: CGFloat = UIScreen.main.bounds.height * 0.69
}
