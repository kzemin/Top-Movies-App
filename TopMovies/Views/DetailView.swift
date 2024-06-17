//
//  DetailView.swift
//  TopMovies
//
//  Created by Facundo Kzemin on 16/06/2024.
//

import SwiftUI

struct DetailView: View {
    // Back button to dismiss view
    @Environment(\.presentationMode) var presentationMode: Binding<PresentationMode>
    @Binding var isActive2: Bool
    
    var body: some View {
        VStack {
            HStack(spacing: 15) {
                
                Button {
                    presentationMode.wrappedValue.dismiss()
                } label: {
                    Image(systemName: "arrow.backward")
                        .resizable()
                        .frame(width: 20, height: 16)
                        .aspectRatio(contentMode: .fit)
                        .foregroundColor(Color("lightGrayGreen2"))
                        .shadow(color: Color("aquaGreen"), radius: 8)
                }
                
                Spacer()
                
                Button {
                    isActive2.toggle()
                } label: {
                    Image(systemName: "square.and.arrow.up.circle.fill")
                        .resizable()
                        .frame(width: 30, height: 30)
                        .aspectRatio(contentMode: .fit)
                        .foregroundColor(Color("lightGrayGreen2"))
                        .shadow(color: Color("aquaGreen"), radius: 8)
                }
            }
            .padding(.horizontal, 25)
        }
    }
}

#Preview {
    DetailView(isActive2: .constant(false))
}

