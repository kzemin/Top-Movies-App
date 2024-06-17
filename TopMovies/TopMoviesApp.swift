//
//  TopMoviesApp.swift
//  TopMovies
//
//  Created by Facundo Kzemin on 16/06/2024.
//

import SwiftUI

@main
struct TopMoviesApp: App {
    @StateObject var mvm = MoviesViewModel()
    
    // Modifier for custom NavigationTitle font and color
    init() {
        let appear = UINavigationBarAppearance()

        let atters: [NSAttributedString.Key: Any] = [
            .font: UIFont(name: "NetflixSans-Bold", size: 30) ?? UIFont.systemFont(ofSize: 30),
            .foregroundColor: UIColor(named: "darkGreen") ?? UIColor.green
        ]

        appear.largeTitleTextAttributes = atters
        appear.titleTextAttributes = atters
        UINavigationBar.appearance().standardAppearance = appear
        UINavigationBar.appearance().compactAppearance = appear
     }
    
    var body: some Scene {
        WindowGroup {
            ContentView()
        }
    }
}
