import SwiftUI

struct MovieCell: View {
    var viewModel: UpcomingMovieCellViewModel

    var body: some View {
        GeometryReader { _ in
            VStack(alignment: .leading) {
                AsyncImage(url: viewModel.posterPath) { image in
                    image
                        .resizable()
                        .aspectRatio(contentMode: .fit)
                        .cornerRadius(16)
                } placeholder: {
                    ProgressView()
                }
                //.frame(width: context.size.width, height: context.size.height * 0.8)
                VStack(alignment: .leading) {
                    Text(viewModel.title)
                        .font(.subheadline)
                        .background(Color.pink)
                        .lineLimit(1)
                    Text(viewModel.releaseDate)
                        .font(.caption)
                        .background(Color.mint)
                        .lineLimit(1)
                }
            }
            .padding(4)
            .onTapGesture {
                viewModel.onTap()
            }
        }
    }
}

struct MovieCell_Previews: PreviewProvider {
    static var previews: some View {
        let tap: () -> Void = {}
        let movie = Movie(adult: nil,
                          backdropPath: nil,
                          genreIDS: nil,
                          id: nil,
                          originalLanguage: nil,
                          originalTitle: nil,
                          overview: "",
                          popularity: nil,
                          posterPath: "/jE5o7y9K6pZtWNNMEw3IdpHuncR.jpg",
                          releaseDate: "Text",
                          title: "Text",
                          video: nil,
                          voteAverage: nil,
                          voteCount: nil)
        let viewModel = UpcomingMovieCellViewModel(movie: movie, onTap: tap)
        MovieCell(viewModel: viewModel)
    }
}
