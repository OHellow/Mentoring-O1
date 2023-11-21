//
//  UpcomingMovieCell.swift
//  Mentoring-O1
//
//  Created by Aleh Satsishur on 17/11/2023.
//

import SwiftUI

struct MovieCell: View {
    var movie: Movie
    var onTap: () -> Void

    var body: some View {
        VStack {
            Image(systemName: "film")
                .resizable()
                .aspectRatio(contentMode: .fit)
                .frame(height: 100)
            HStack() {
                Text(movie.title)
                    .font(.headline)
                Text("Release Date: \(movie.releaseDate)")
                    .font(.subheadline)
            }
            .padding()
        }
        .border(Color.gray, width: 1)
        .cornerRadius(8)
        .padding(8)
        .onTapGesture {
            onTap()
        }
    }
}

#Preview {
    UpcomingMovieCell()
}
