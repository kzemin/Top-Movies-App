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
    
    // Modifier for custom NavigationTitle size and color
    init() {
        let appear = UINavigationBarAppearance()

        let atters: [NSAttributedString.Key: Any] = [
            .font: UIFont.systemFont(ofSize: 30, weight: .bold),
            .foregroundColor: UIColor.white
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
