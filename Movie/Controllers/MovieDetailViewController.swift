//
//  MovieDetailViewController.swift
//  Movie
//
//  Created by Pallavi Agarwal on 03/08/21.
//  Copyright © 2021 Demo. All rights reserved.
//

import UIKit

class MovieDetailViewController: UIViewController,UITableViewDataSource {
    @IBOutlet var tblViewMovieDetail : UITableView!
    var objMovieDetailViewModel : MovieDetailViewModel!
    var objMovieDetailModel : MoveiDetailModel!
    var imgID : String?
    @IBOutlet var headerView: MovieDetailHeaderView!
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        // Set the table view data source
        tblViewMovieDetail.dataSource = self
        
        self.title = "Movie Detail"
        objMovieDetailViewModel = MovieDetailViewModel()
        
        if let imgIdMovie = imgID
        {
            callMovieDetailAPI(movieId: imgIdMovie)
        
        }
    }
    
    func callMovieDetailAPI(movieId : String)  {
        objMovieDetailViewModel?.getAPIData(param: ["apikey":Constants.APIKeys.kAPIKey, "i" : movieId], completion: { (model, error) in
            if let _ = error {
                DispatchQueue.main.async {
                    let alert = UIAlertController(title: "Error", message: error?.message, preferredStyle: UIAlertController.Style.alert)
                    alert.addAction(UIAlertAction(title: "OK", style: .default, handler: nil))

                    self.present(alert, animated: true, completion: nil)
                }
                
            } else {
                if let movieDetailModel = model {
                    self.objMovieDetailModel = movieDetailModel
                                        DispatchQueue.main.async {
                                            self.configureHeader()
                                            self.tblViewMovieDetail?.reloadData()
                                        }
                }
                
            }
        })
    }
    
    //Configure HeaderView
    func configureHeader()  {
        headerView.lblTitle.text = self.objMovieDetailModel.Title
        headerView.lblYear.text = self.objMovieDetailModel.Year
        headerView.imgViewPoster.loadImage(urlString:self.objMovieDetailModel.Poster , placeHolderImage: "")
    }
    
    // MARK: - UITableViewDataSource methods

    func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        if (self.objMovieDetailModel != nil) {
            return 2
        }
        return 0
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        switch indexPath.row {
            
        case 0:
            let cell = tableView.dequeueReusableCell(withIdentifier: String(describing: MovieDetailDescriptionTableViewCell.self), for: indexPath) as! MovieDetailDescriptionTableViewCell

            cell.configure(objMovieDetailModel: self.objMovieDetailModel)
            cell.selectionStyle = .none
            
            return cell
        case 1:
            let cell = tableView.dequeueReusableCell(withIdentifier: String(describing: MovieDetailCreatorTableViewCell.self), for: indexPath) as! MovieDetailCreatorTableViewCell
            cell.selectionStyle = .none
            cell.configure(objMovieDetailModel: self.objMovieDetailModel)
            return cell

            
        default:
            fatalError("Failed to instantiate the table view cell for detail view controller")
        }
    }

}
