//
//  Extensions.swift
//  TopMovies
//
//  Created by Facundo Kzemin on 16/06/2024.
//

import Foundation
import SwiftUI

// MARK: Custom fonts
extension UIFont {
    static func NetflixSansBold(size: CGFloat) -> UIFont {
        if let font = UIFont(name: "NetflixSans-Bold", size: size) {
            return font
        }
        
        // Fallback
        return UIFont.systemFont(ofSize: size, weight: .bold)
    }
    
    static func NetflixSansMedium(size: CGFloat) -> UIFont {
        if let font = UIFont(name: "NetflixSans-Medium", size: size) {
            return font
        }
        
        // Fallback
        return UIFont.systemFont(ofSize: size, weight: .medium)
    }
    
    static func NetflixSansRegular(size: CGFloat) -> UIFont {
        if let font = UIFont(name: "NetflixSans-Regular", size: size) {
            return font
        }
        
        // Fallback
        return UIFont.systemFont(ofSize: size, weight: .regular)
    }
    
    static func NetflixSansLight(size: CGFloat) -> UIFont {
        if let font = UIFont(name: "NetflixSans-Light", size: size) {
            return font
        }
        
        // Fallback
        return UIFont.systemFont(ofSize: size, weight: .light)
    }
}

extension Font {
    static func NetflixSansBold(size: CGFloat) -> Font {
        return Font.custom("NetflixSans-Bold", size: size)
    }
    
    static func NetflixSansMedium(size: CGFloat) -> Font {
        return Font.custom("NetflixSans-Medium", size: size)
    }
    
    static func NetflixSansRegular(size: CGFloat) -> Font {
        return Font.custom("NetflixSans-Regular", size: size)
    }
    
    static func NetflixSansLight(size: CGFloat) -> Font {
        return Font.custom("NetflixSans-Light", size: size)
    }
}
