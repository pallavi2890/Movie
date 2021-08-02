//
//  MoveiModel.swift
//  Movie
//
//  Created by Pallavi Agarwal on 30/07/21.
//  Copyright © 2021 Demo. All rights reserved.
//

import Foundation

/*struct MovieModel : Codable {
    var Search : [Search]
}

struct Search : Codable, Hashable {
    
    var Title : String = ""
    var Year : String = ""
    var imdbID : Int = 0
    var `Type` : String = ""
    var Poster : String = ""
    
    enum CodingKeys: String, CodingKey {
        case Title
        case Year
        case imdbID
        case `Type`
        case Poster
    }
    
    init(from decoder: Decoder) throws {
        let values = try decoder.container(keyedBy: CodingKeys.self)
        
        Title = try values.decode(String.self, forKey: .Title)
        
        Year = try values.decode(String.self, forKey: .Year)
        imdbID = try values.decode(Int.self, forKey: .imdbID)
        Type = try values.decode(String.self, forKey: .Type)
        Poster = try values.decode(String.self, forKey: .Poster)
        
    }
}*/
