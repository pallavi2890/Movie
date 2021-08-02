//
//  MovieDetailAPI.swift
//  Movie
//
//  Created by Pallavi Agarwal on 30/07/21.
//  Copyright © 2021 Demo. All rights reserved.
//

import Foundation

struct MovieDetailAPI : APIHandler {
    func makeRequest(from param: [String: Any]) -> URLRequest? {
        //let urlString =  APIPath().gallary
        //let urlString = "http://www.omdbapi.com/?"
     let urlString = "http://www.omdbapi.com/?apikey=def4478&s=Avengers&type=movie"
         
        if var url = URL(string: urlString) {
            if param.count > 0 {
                url = setQueryParams(parameters: param, url: url)
            }
            var urlRequest = URLRequest(url: url)
            #warning("Pallavi check header")
            //setDefaultHeaders(request: &urlRequest)
            urlRequest.httpMethod = HTTPMethod.get.rawValue
            return urlRequest
        }
        return nil
    }
    
    func parseResponse(data: Data, response: HTTPURLResponse) throws -> MoveiDetailModel {
        return try defaultParseResponse(data: data,response: response)
    }
}
