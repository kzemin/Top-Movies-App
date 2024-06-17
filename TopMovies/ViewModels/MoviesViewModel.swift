//
//  MoviesViewModel.swift
//  TopMovies
//
//  Created by Facundo Kzemin on 16/06/2024.
//

import Foundation

class MoviesViewModel: ObservableObject {
    
    // All loaded movies
    @Published var movies: [Movie] = []
    
    init() {
        
    }
    
    func fetchTopMovies() {
        let baseURL = "https://api.themoviedb.org/3/"
        let API_KEY = "64c826decda582487cfdeb7edd8ba008"
        let headers = [
            "accept": "application/json",
            "Authorization": "Bearer eyJhbGciOiJIUzI1NiJ9.eyJhdWQiOiI2NGM4MjZkZWNkYTU4MjQ4N2NmZGViN2VkZDhiYTAwOCIsInN1YiI6IjY1ZjI0NTRjMmZkZWM2MDE3MDIxNjllNyIsInNjb3BlcyI6WyJhcGlfcmVhZCJdLCJ2ZXJzaW9uIjoxfQ.LjdUP-6GKGfQ66j8i81kPWtBoWj17H6NCr-FnXkQLiA"
        ]
        
        let request = NSMutableURLRequest(url: NSURL(string: "\(baseURL)/movie/popular?api_key=\(API_KEY)&page=1")! as URL,
                                          cachePolicy: .useProtocolCachePolicy,
                                          timeoutInterval: 10.0)
        
        request.httpMethod = "GET"
        request.allHTTPHeaderFields = headers
        
        let session = URLSession.shared
        let dataTask = session.dataTask(with: request as URLRequest) { [weak self] (data, response, error) in
            guard let self = self else { return }
            
            if let error = error {
                print("Error fetching data: \(error)")
                return
            }
            
            guard let data = data else {
                print("No data received")
                return
            }
            
            do {
                let decoder = JSONDecoder()
                let movieResponse = try decoder.decode(MovieResponse.self, from: data)
                
                // Returns each movie from API and adapts it to the Movie object
                let movieInfoArray = movieResponse.results.map { movie in
                    
                    // Normalize the voteAverage to a 0-5 scale
                    let normalRating = (movie.voteAverage / 2)
                    return Movie(
                        title: movie.title,
                        description: movie.overview,
                        datePublished: movie.releaseDate,
                        rating: normalRating,
                        backdropPath: movie.backdropPath ?? ""
                    )
                }
                
                DispatchQueue.main.async {
                    self.movies = movieInfoArray
                }
            } catch {
                print("Error decoding JSON: \(error)")
            }
        }
        
        dataTask.resume()
    }
}
