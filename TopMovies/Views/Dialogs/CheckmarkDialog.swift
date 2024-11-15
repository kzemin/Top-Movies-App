//
//  CheckmarkDialog.swift
//  TopMovies
//
//  Created by Facundo Kzemin on 16/06/2024.
//

import SwiftUI

struct CheckmarkDialog: View {
    @Binding var isActive: Bool
    @State private var opacity: CGFloat = 0
    
    var body: some View {
        ZStack {
            RoundedRectangle(cornerRadius: 25)
                .frame(width: 150, height: 150)
                .foregroundColor(Color("lightGrayGreen"))
            
            Image(systemName: "checkmark.circle")
                .resizable()
                .frame(width: 100, height: 100)
                .foregroundColor(Color("lightGreen"))
        }
        .frame(width: 150, height: 150)
        .opacity(opacity)
        .onAppear {
            withAnimation(.easeIn.speed(0.5)) {
                opacity = 1
                isActive = true
            }
            withAnimation(.easeOut.speed(0.5).delay(1.5)) {
                opacity = 0
            }
        }
    }
}

#Preview {
    CheckmarkDialog(isActive: .constant(false))
}
