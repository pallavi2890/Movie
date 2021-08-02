//
//  MovieViewModel.swift
//  Movie
//
//  Created by Pallavi Agarwal on 30/07/21.
//  Copyright © 2021 Demo. All rights reserved.
//

import Foundation

struct MovieViewModel {
    func getAPIData(param: [String: Any], completion: @escaping (MovieModelNew?, ServiceError?) -> ()) {
        let request = MovieListAPI()
        
        let apiLoader = APILoader(apiHandler: request)
        apiLoader.loadAPIRequest(requestData: param) { (model, error) in
            if let _ = error {
                completion(nil, error)
            } else {
                completion(model, nil)
            }
        }
    }
}
