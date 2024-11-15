//
//  NotAvailableDialog.swift
//  TopMovies
//
//  Created by Facundo Kzemin on 16/06/2024.
//

import SwiftUI

struct NotAvailableDialog: View {
    @Binding var isActive2: Bool
    @State private var offset: CGFloat = 1000
    
    var body: some View {
        VStack {
            Text("🚧")
                .font(.system(size: 36))
                .padding(3)
            
            Text("Feature under \nconstruction!")
                .font(.NetflixSansBold(size: 24))
                .foregroundColor(Color("aquaGreen"))
                .multilineTextAlignment(.center)
            
            Button {
                close()
            } label: {
                ZStack {
                    RoundedRectangle(cornerRadius: 20)
                        .foregroundColor(Color("aquaGreen"))
                    
                    Text("Ok")
                        .font(.NetflixSansBold(size: 20))
                        .foregroundColor(.white)
                        .padding()
                }
                .padding()
            }
            
        }
        .fixedSize(horizontal: false, vertical: true)
        .padding()
        .background(.white)
        .clipShape(RoundedRectangle(cornerRadius: 20))
        .overlay(alignment: .topTrailing) {
            Button {
                close()
            } label: {
                Image(systemName: "xmark")
                    .font(.NetflixSansMedium(size: 20))
                    .foregroundColor(Color("grayGreen"))
            }
            .padding()
            
        }
        .shadow(radius: 20)
        .padding(30)
        .offset(x: 0, y: offset)
        .onAppear {
            withAnimation(.snappy.speed(0.6)) {
                offset = 0
            }
        }
        .ignoresSafeArea(.all)
    }
    
    func close() {
        withAnimation(.snappy.speed(0.6)) {
            offset = 1000
            isActive2 = false
        }
    }
}

#Preview {
    NotAvailableDialog(isActive2: .constant(false))
}
