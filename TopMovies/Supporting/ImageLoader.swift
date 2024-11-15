//
//  ImageLoader.swift
//  TopMovies
//
//  Created by Facundo Kzemin on 16/06/2024.
//

import Foundation
import UIKit

class ImageLoader: ObservableObject {
    @Published var image: UIImage?
    @Published var isLoading = false
    
    private var imageCache = NSCache<AnyObject, AnyObject>()
    
    func loadImage(with url: URL) {
        let urlString = url.absoluteString
        if let imageFromCache = imageCache.object(forKey: urlString as AnyObject) as? UIImage {
            self.image = imageFromCache
            print("Loaded image from cache: \(urlString)")
            return
        }
        
        isLoading = true
        
        print("Fetching image from URL: \(urlString)")
        
        DispatchQueue.global(qos: .background).async { [weak self] in
            guard let self = self else { return }
            do {
                let data = try Data(contentsOf: url)
                guard let image = UIImage(data: data) else {
                    print("Could not create image from data")
                    DispatchQueue.main.async {
                        self.isLoading = false
                    }
                    return
                }
                
                self.imageCache.setObject(image, forKey: urlString as AnyObject)
                
                DispatchQueue.main.async { [weak self] in
                    self?.image = image
                    print("Image loaded and published: \(urlString)")
                    self?.isLoading = false
                }
            } catch {
                print(error.localizedDescription)
                DispatchQueue.main.async {
                    self.isLoading = false
                }
            }
        }
    }
}
