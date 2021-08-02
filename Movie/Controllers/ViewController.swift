//
//  ViewController.swift
//  Movie
//
//  Created by Pallavi Agarwal on 30/07/21.
//  Copyright © 2021 Demo. All rights reserved.
//

import UIKit

class ViewController: UIViewController {
    
    public var objMovieViewModel: MovieViewModel?
    override func viewDidLoad() {
        super.viewDidLoad()
        objMovieViewModel = MovieViewModel()
        // Do any additional setup after loading the view, typically from a nib.
        
       callMoviListAPI()
        
    }

    func callMoviListAPI()  {
        objMovieViewModel?.getAPIData(param: [:], completion: { (model, error) in
            if let _ = error {
                DispatchQueue.main.async {
                    let alert = UIAlertController(title: "Error", message: error?.message, preferredStyle: UIAlertController.Style.alert)
                    self.present(alert, animated: true, completion: nil)
                }
            } else {
                if let modelUW = model {
                    //                    self.dataSource = modelUW.results
                    //                    DispatchQueue.main.async {
                    //                        self.collectionView?.reloadData()
                    //                    }
                    print("movie data = \(modelUW.Search)")
                }
            }
        })
    }

}

