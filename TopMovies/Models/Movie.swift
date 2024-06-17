//
//  Movie.swift
//  TopMovies
//
//  Created by Facundo Kzemin on 16/06/2024.
//

import Foundation
import SwiftUI

struct Movie: Identifiable, Codable {
    var id = UUID()
    let title: String
    let description: String
    let datePublished: String
    let rating: Double
    let backdropPath: String?
    
    var posterURL: URL? {
        guard let path = backdropPath else {
            return nil
        }
        return URL(string: "https://image.tmdb.org/t/p/w500\(path)")
    }
    
    var backdropURL: URL {
        return URL(string: "https://image.tmdb.org/t/p/w500\(backdropPath ?? "")")!
    }
}
