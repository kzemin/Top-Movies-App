//
//  LoadingScreenView.swift
//  TopMovies
//
//  Created by Facundo Kzemin on 16/06/2024.
//

import SwiftUI

struct LoadingScreenView: View {
    @State private var offset: CGFloat = 1000
    @Binding var isActive: Bool
    
    var body: some View {
        ZStack {
            Color("darkGreen")
                .frame(height: UIScreen.main.bounds.height)
                .ignoresSafeArea(.all)
            
            VStack(alignment: .leading) {
                Text("Top \nRated")
                    .font(.NetflixSansBold(size: 40))
                
                Text("Movies 🍿")
                    .font(.NetflixSansLight(size: 40))
            }
            .foregroundColor(.white)
            .shadow(radius: 8)
            .offset(x: 0, y: offset)
            .onAppear {
                withAnimation(.bouncy.speed(0.6)) {
                    offset = 0
                }
            }
            .onAppear {
                DispatchQueue.main.asyncAfter(deadline: .now() + 3) {
                    withAnimation(.bouncy.speed(0.6)) {
                        offset = 1000
                    }
                }
            }
        }
    }
}

#Preview {
    LoadingScreenView(isActive: .constant(true))
}
