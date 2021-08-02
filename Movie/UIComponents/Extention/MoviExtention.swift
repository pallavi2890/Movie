//
//  MoviExtention.swift
//  Movie
//
//  Created by Pallavi Agarwal on 31/07/21.
//  Copyright © 2021 Demo. All rights reserved.
//

import Foundation
import UIKit

var imageChache = NSCache<AnyObject,AnyObject>()

extension UIImageView {
    
    func loadImage(urlString : String,placeHolderImage: String) {
        
        self.image = UIImage(named: placeHolderImage)
    
        if let cachedImage = imageChache.object(forKey: urlString as NSString) as? UIImage
        {
            self.image = cachedImage
            return
        }
        
        guard let url = URL(string: urlString)else {
            return
        }
        DispatchQueue.global().async { [weak self] in
            if let data = try? Data(contentsOf: url) {
                if let image = UIImage(data: data) {
                    DispatchQueue.main.async {
                        imageChache.setObject(image, forKey: urlString as NSString)
                        self?.image = image
                    }
                }
            }
        }
    }
}
