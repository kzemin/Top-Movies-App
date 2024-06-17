//
//  MovieListView.swift
//  TopMovies
//
//  Created by Facundo Kzemin on 16/06/2024.
//

import SwiftUI

struct MovieListView: View {
    @StateObject var viewModel = MoviesViewModel()
    @ObservedObject var imageLoader = ImageLoader()
    
    var body: some View {
        List(viewModel.movies) { movie in
            NavigationLink(destination: MovieDetailView(movie: movie)) {
                HStack(alignment: .top) {
                    if let imageURL = movie.posterURL {
                        AsyncImage(
                            url: imageURL,
                            content: { image in
                                image.resizable()
                                    .frame(width: 50, height: 50)
                                    .scaledToFill()
                                    .cornerRadius(5)
                            },
                            placeholder: {
                                ProgressView()
                            }
                        )
                        .padding(3)
                    } else {
                        ZStack {
                            Rectangle()
                                .fill(Color("grayGreen"))
                                .frame(width: 50, height: 50)
                                .cornerRadius(5)
                            
                            ProgressView()
                        }
                    }
                    
                    VStack(alignment: .leading) {
                        Text(movie.title)
                            .font(.NetflixSansMedium(size: 22))
                            .foregroundColor(Color("darkGreen"))
                        
                        Text(movie.datePublished)
                            .font(.NetflixSansLight(size: 14))
                            .foregroundColor(Color("grayGreen"))
                    }
                }
            }
        }
        .navigationTitle("Top Rated Movies 🍿")
        .onAppear {
            viewModel.fetchTopMovies()
            viewModel.movies.forEach { movie in
                let posterURLString = "https://image.tmdb.org/t/p/w500\(String(describing: movie.posterURL))"
                if let posterURL = URL(string: posterURLString) {
                    self.imageLoader.loadImage(with: posterURL)
                } else {
                    print("Invalid poster URL")
                }
            }
        }
    }
}

#Preview {
    MovieListView()
}
