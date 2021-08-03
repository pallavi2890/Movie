//
//  MovieDetailViewModel.swift
//  Movie
//
//  Created by Pallavi Agarwal on 03/08/21.
//  Copyright © 2021 Demo. All rights reserved.
//

import Foundation

struct MovieDetailViewModel {
    func getAPIData(param: [String: Any], completion: @escaping (MoveiDetailModel?, ServiceError?) -> ()) {
        let request = MovieDetailAPI()
        
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
