//
//  MovieListView.swift
//  TopMovies
//
//  Created by Facundo Kzemin on 16/06/2024.
//

import SwiftUI

struct MovieListView: View {
    @StateObject var viewModel = MoviesViewModel()
    @State private var selectedMovie: Movie?
    @State private var showingMovieDetail = false
    
    var body: some View {
        NavigationStack {
            MovieTableView(viewModel: viewModel) { movie in
                selectedMovie = movie
                showingMovieDetail = true
            }
            .navigationDestination(isPresented: $showingMovieDetail) {
                if let movie = selectedMovie {
                    MovieDetailView(movie: movie)
                }
            }
            .onAppear {
                viewModel.fetchTopMovies()
            }
        }
    }
}
       
#Preview {
    MovieListView()
}

