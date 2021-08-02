//
//  MovieCollectionViewCell.swift
//  Movie
//
//  Created by Pallavi Agarwal on 31/07/21.
//  Copyright © 2021 Demo. All rights reserved.
//

import UIKit

class MovieCollectionViewCell: UICollectionViewCell {
    
    @IBOutlet weak var imgViewMoviePoster: UIImageView!
    @IBOutlet weak var lblMoviTitle: UILabel!
    
    
    func configure(imageURL: String, title: String) {
        self.backgroundColor = UIColor.black
        self.lblMoviTitle.textColor = UIColor.white
        self.lblMoviTitle?.text = title
        imgViewMoviePoster.loadImage(urlString: imageURL, placeHolderImage: "")
    }
}
