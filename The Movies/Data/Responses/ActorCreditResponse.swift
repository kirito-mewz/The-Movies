//
//  ActorCreditResponse.swift
//  The Movies
//
//  Created by Paing Htet on 03/08/2025.
//

import Foundation

struct ActorCreditResponse: Codable {
    
    var id: Int?
    var movies: [MovieDetailResponse]?
    
    enum CodingKeys: String, CodingKey {
        case id
        case movies = "cast"
    }
}
