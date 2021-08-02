//
//  MoveiDetailModel.swift
//  Movie
//
//  Created by Pallavi Agarwal on 30/07/21.
//  Copyright © 2021 Demo. All rights reserved.
//

import Foundation

struct MoveiDetailModel : Codable {
    var Title : String = ""
    var Year : String = ""
    var Rated : String = ""
    var Released : String = ""
    var Runtime : String = ""
    var Genre : String = ""
    var Director : String = ""
    var Writer : String = ""
    var Actors : String = ""
    var Plot : String = ""
    var Language : String = ""
    var Country : String = ""
    var Awards : String = ""
    var Metascore : String = ""
    var imdbRating : String = ""
    var Poster : String = ""
    var imdbVotes : String = ""
    var imdbID : String = ""
    var `Type` : String = ""
    var DVD : String = ""
    var BoxOffice : String = ""
    var Production : String = ""
    var Website : String = ""
    var Response : Bool = false
    var Ratings : [Rating]
    
    enum CodingKeys : String,CodingKey {
        case Title
        case Year
        case Rated
        case Released
        case Runtime
        case Genre
        case Director
        case Writer
        case Actors
        case Plot
        case Language
        case Country
        case Awards
        case Metascore
        case imdbRating
        case Poster
        case imdbVotes
        case imdbID
        case `Type`
        case DVD
        case BoxOffice
        case Production
        case Website
        case Response
        case Ratings
    }
}

struct Rating : Codable {
    var Source : String = ""
    var Value : String = ""
    
    enum CodingKeys : String,CodingKey {
        case Source
        case Value
    }
    
    init(from decoder: Decoder) throws {
        let values = try decoder.container(keyedBy: CodingKeys.self)
        
        Source = try values.decode(String.self, forKey: .Source)
        Value = try values.decode(String.self, forKey: .Value)
        
    }
    
}

