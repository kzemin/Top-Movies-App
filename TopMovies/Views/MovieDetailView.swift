//
//  MovieDetailView.swift
//  TopMovies
//
//  Created by Facundo Kzemin on 16/06/2024.
//

import SwiftUI
import Combine

struct MovieDetailView: View {
    @State var isActive: Bool = false
    @State var isActive2: Bool = false
    let movie: Movie
    
    var body: some View {
        ScrollView {
            GeometryReader { geo in
                ZStack {
                    if let imageURL = movie.posterURL {
                        AsyncImage(url: imageURL)
                            .scaledToFill()
                            .frame(width: geo.size.width, height: geo.size.height)
                            .ignoresSafeArea(.all)
                            .clipped()
                    } else {
                        ZStack {
                            Rectangle()
                                .fill(Color.gray.opacity(0.3))
                                .frame(width: geo.size.width, height: geo.size.height)
                                .clipped()
                            
                            ProgressView()
                        }
                    }
                    
                    DetailView(isActive2: $isActive2)
                        .padding(.bottom, 140)
                }
            }
            .frame(height: UIScreen.main.bounds.width * 0.65)
            // Adapts the height based on the screen width mantaining aspect ratio
            
            movieInfoView
            // Show popups
            .overlay(overlayView)
        }
        .navigationBarTitle("")
        .navigationBarBackButtonHidden()
        .edgesIgnoringSafeArea(.all)
        // Logic for popups and bug prevention
        .onReceive(Just(isActive2)) { newValue in
            if newValue {
                isActive = false
            }
        }

    }
    
    //  Popups overlay
    private var overlayView: some View {
        if isActive2 {
            return AnyView(NotAvailableDialog(isActive2: $isActive2))
        } else if isActive {
            return AnyView(CheckmarkDialog(isActive: $isActive))
        } else {
            return AnyView(EmptyView())
        }
    }
    
    private var movieInfoView: some View {
        VStack(alignment: .leading, spacing: 10) {
            HStack {
                Text(movie.title)
                    .font(.NetflixSansBold(size: 28))
                    .foregroundColor(Color("darkGreen"))
                
                Spacer()
                
                Button {
                    isActive.toggle()
                } label: {
                    HStack(alignment: .bottom) {
                        Image(systemName: "plus.circle")
                            .resizable()
                            .bold()
                            .frame(width: 20, height: 20)
                        
                        Text("Watch later")
                            .font(.NetflixSansBold(size: 17))
                    }
                    .foregroundColor(.white)
                    .padding(14)
                    .background(Color("aquaGreen"))
                    .cornerRadius(50)
                }
            }
            
            Group {
                HStack {
                    Text(movie.datePublished)
                        .font(.NetflixSansLight(size: 12))
                        .foregroundColor(Color("grayGreen"))
                    
                    Text(" • ")
                        .font(.NetflixSansBold(size: 12))
                        .foregroundColor(Color("grayGreen"))
                    
                    HStack(spacing: 2) {
                        ForEach(0..<5) { index in
                            Image(systemName: index < Int(movie.rating) ? "star.fill" : "star")
                                .resizable()
                                .frame(width: 10, height: 10)
                                .foregroundColor(index < Int(movie.rating) ? .yellow : .gray)
                        }
                    }
                }
            }
            
            Text(movie.description)
                .lineLimit(nil)
                .font(.NetflixSansRegular(size: 17))
                .foregroundColor(Color("aquaGreen"))
                .padding(.bottom, 15)
        }
        .padding(.horizontal)
        .padding(.top, 10)
    }
}

#Preview {
    MovieDetailView(movie: Movie(title: "Damsel", description: "Lorem ipsum dolor sit amet, consectetur adipiscing elit. Suspendisse aliquet sollicitudin ex et fringilla. Suspendisse odio enim, imperdiet eu sem vehicula, aliquet ornare ipsum. Fusce efficitur ipsum id mauris fringilla, a lobortis libero interdum. Morbi feugiat felis ac ligula ullamcorper sodales.", datePublished: "2024-03-08", rating: 4, backdropPath: ""))
}
