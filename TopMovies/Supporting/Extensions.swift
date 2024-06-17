//
//  Extensions.swift
//  TopMovies
//
//  Created by Facundo Kzemin on 16/06/2024.
//

import Foundation
import SwiftUI

extension Font {
    // MARK: Custom fonts
    static func NetflixSansBold(size: Int) -> Font {
        return Font.custom("NetflixSans-Bold", size: CGFloat(size))
    }
    
    static func NetflixSansMedium(size: Int) -> Font {
        return Font.custom("NetflixSans-Medium", size: CGFloat(size))
    }
    
    static func NetflixSansRegular(size: Int) -> Font {
        return Font.custom("NetflixSans-Regular", size: CGFloat(size))
    }
    
    static func NetflixSansLight(size: Int) -> Font {
        return Font.custom("NetflixSans-Light", size: CGFloat(size))
    }
}
