//
//  CustomImageView.swift
//  DecoableJSON
//
//  Created by Jeffrey Chang on 11/28/18.
//  Copyright © 2018 Jeffrey Chang. All rights reserved.
//

import UIKit

var imageCache = [String: UIImage]()

class CustomImageView: UIImageView {
    
    var lastUrlUsedToLoadImage: String?
    
    func scaleImageToSize(size: CGSize) {
        UIGraphicsBeginImageContext(size)
        
        image?.draw(in: CGRect(origin: CGPoint.zero, size: size))
        
        UIGraphicsEndImageContext()
        
        guard let scaledImage = UIGraphicsGetImageFromCurrentImageContext() else {return}
        self.image = scaledImage
        
    }
    
    func loadImage(urlString: String?) {
        guard let urlString = urlString else {
            self.image = UIImage(named: "add_photo")
            return
        }
        lastUrlUsedToLoadImage = urlString
        
        if let cachedimage = imageCache[urlString] {
            self.image = cachedimage
            return
        }
        
        guard let url = URL(string: urlString) else { return }
        
        URLSession.shared.dataTask(with: url) { (data, response, err) in
            if let err = err {
                print("Failed to fetch post image:", err)
                return
            }
            
            if url.absoluteString != self.lastUrlUsedToLoadImage {
                return
            }
            
            guard let imageData = data else { return }
            
            let photoImage = UIImage(data: imageData)
            
            imageCache[url.absoluteString] = photoImage
            
            DispatchQueue.main.async {
                self.image = photoImage
            }
            
            }.resume()
    }
}


