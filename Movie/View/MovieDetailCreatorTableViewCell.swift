//
//  MovieDetailCreatorTableViewCell.swift
//  Movie
//
//  Created by Pallavi Agarwal on 03/08/21.
//  Copyright © 2021 Demo. All rights reserved.
//

import UIKit

class MovieDetailCreatorTableViewCell: UITableViewCell {
    
    @IBOutlet var lblDirector: UILabel!
    @IBOutlet var lblWriter: UILabel!
    @IBOutlet var lblActor: UILabel!

    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }
   
    func configure(objMovieDetailModel : MoveiDetailModel)  {
        self.lblDirector.text = "Director : \(objMovieDetailModel.Director)"
        self.lblWriter.text = "Writer : \(objMovieDetailModel.Writer)"
        self.lblActor.text = "Actor : \(objMovieDetailModel.Actors)"
    }
}
