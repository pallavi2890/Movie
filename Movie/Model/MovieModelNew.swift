//
//  MovieModelNew.swift
//  Movie
//
//  Created by Pallavi Agarwal on 02/08/21.
//  Copyright © 2021 Demo. All rights reserved.
//

import Foundation
/*struct Loan: Codable {
    
    var name: String = ""
    var country: String = ""
    var use: String = ""
    var amount: Int = 0

    enum CodingKeys: String, CodingKey {
        case name
        case country = "location"
        case use
        case amount = "loan_amount"
    }
    
    enum LocationKeys: String, CodingKey {
        case country
    }
    
    init(from decoder: Decoder) throws {
        let values = try decoder.container(keyedBy: CodingKeys.self)
        
        name = try values.decode(String.self, forKey: .name)
        
        let location = try values.nestedContainer(keyedBy: LocationKeys.self, forKey: .country)
        country = try location.decode(String.self, forKey: .country)
        
        use = try values.decode(String.self, forKey: .use)
        amount = try values.decode(Int.self, forKey: .amount)
        
    }
}*/


struct MovieModelNew: Codable {
    var Search : [Search]
}

struct Search : Codable {
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
        `Type` = try values.decode(String.self, forKey: .Year)
        Poster = try values.decode(String.self, forKey: .Poster)
    }
}
