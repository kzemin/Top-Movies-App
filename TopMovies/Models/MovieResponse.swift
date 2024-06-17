//
//  MovieResponse.swift
//  TopMovies
//
//  Created by Facundo Kzemin on 16/06/2024.
//

import Foundation

struct MovieResponse: Codable {
    let page: Int
    let results: [MovieResult]
    let totalPages: Int
    let totalResults: Int
    
    enum CodingKeys: String, CodingKey {
        case page
        case results
        case totalPages = "total_pages"
        case totalResults = "total_results"
    }
}

struct MovieResult: Codable {
    let id: Int
    let title: String
    let overview: String
    let releaseDate: String
    let voteAverage: Double
    let posterPath: String?
    let backdropPath: String?
    
    enum CodingKeys: String, CodingKey {
        case id
        case title
        case overview
        case releaseDate = "release_date"
        case voteAverage = "vote_average"
        case posterPath = "poster_path"
        case backdropPath = "backdrop_path"
    }
}
