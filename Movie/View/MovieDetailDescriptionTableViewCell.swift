//
//  MovieDetailDescriptionTableViewCell.swift
//  Movie
//
//  Created by Pallavi Agarwal on 03/08/21.
//  Copyright © 2021 Demo. All rights reserved.
//

import UIKit

class MovieDetailDescriptionTableViewCell: UITableViewCell {
   
    @IBOutlet var lblCategory: UILabel!
    @IBOutlet var lblDuration: UILabel!
    @IBOutlet var lblRating: UILabel!
    @IBOutlet var lblDesc: UILabel!
    @IBOutlet var lblScoreValue: UILabel!
    @IBOutlet var lblReviews: UILabel!
    @IBOutlet var lblVote: UILabel!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }
    
    func configure(objMovieDetailModel : MoveiDetailModel)  {
        self.lblCategory.text = "Category:\n\(objMovieDetailModel.Genre) "
        self.lblDuration.text = objMovieDetailModel.duration
        self.lblRating.text = objMovieDetailModel.imdbRating
        self.lblDesc.text = objMovieDetailModel.Plot
        self.lblScoreValue.text = objMovieDetailModel.Metascore
        self.lblReviews.text = "good"
        self.lblVote.text = objMovieDetailModel.imdbVotes
    }

}
