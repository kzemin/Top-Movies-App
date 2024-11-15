//
//  ContentView.swift
//  TopMovies
//
//  Created by Facundo Kzemin on 16/06/2024.
//

import SwiftUI

struct ContentView: View {
    @State var isActive = true
    
    var body: some View {
        NavigationStack {
            ZStack {
                if isActive {
                    LoadingScreenView(isActive: $isActive)
                } else {
                    VStack {
                        Rectangle()
                            .fill(Color.clear)
                            .frame(height: UIScreen.main.bounds.width * 0.1)
                            .background(Color("darkGreen"))
                            .padding(-15)
                        
                        MovieListView()
                            .edgesIgnoringSafeArea(.bottom)
                            .background(Color.red)
                    }
                    .navigationTitle("Top Rated Movies 🍿")
                }
            }
            .onAppear {
                // Dismiss LoadingScreen
                DispatchQueue.main.asyncAfter(deadline: .now() + 3) {
                    self.isActive = false
                }
            }
        }
    }
}

#Preview {
    ContentView()
}
