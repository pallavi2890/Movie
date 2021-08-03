//
//  MoveiListAPI.swift
//  Movie
//
//  Created by Pallavi Agarwal on 30/07/21.
//  Copyright © 2021 Demo. All rights reserved.
//

import Foundation

struct MovieListAPI : APIHandler{
    func makeRequest(from param: [String: Any]) -> URLRequest? {
        let urlString = "http://www.omdbapi.com/?" 
       
        if var url = URL(string: urlString) {
            if param.count > 0 {
                url = setQueryParams(parameters: param, url: url)
            }
            var urlRequest = URLRequest(url: url)
            urlRequest.httpMethod = HTTPMethod.get.rawValue
            return urlRequest
        }
        return nil
    }
    
    func parseResponse(data: Data, response: HTTPURLResponse) throws -> MovieModel {
        return try defaultParseResponse(data: data,response: response)
    }
}
