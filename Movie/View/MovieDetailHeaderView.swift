//
//  MovieDetailHeaderView.swift
//  Movie
//
//  Created by Pallavi Agarwal on 03/08/21.
//  Copyright © 2021 Demo. All rights reserved.
//

import UIKit

class MovieDetailHeaderView: UIView {

    @IBOutlet var imgViewPoster: UIImageView!
    @IBOutlet var lblTitle: UILabel! {
        didSet {
            lblTitle.numberOfLines = 0
        }
    }
    @IBOutlet var lblYear: UILabel! {
        didSet {
            lblTitle.numberOfLines = 0
        }
    }
  
}
