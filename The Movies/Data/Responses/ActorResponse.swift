//
//  ActorResponse.swift
//  The Movies
//
//  Created by Paing Htet on 03/08/2025.
//

import Foundation

// MARK: - ActorResponse
struct ActorResponse: Codable {
    let page: Int?
    let actors: [Actor]?
    let totalPages, totalResults: Int?
    
    enum CodingKeys: String, CodingKey {
        case page
        case actors = "results"
        case totalPages = "total_pages"
        case totalResults = "total_results"
    }
}

// MARK: - Actor
struct Actor: Codable {
    let adult: Bool?
    let gender: Int?
    let id: Int?
    let role, name, originalName: String?
    let popularity: Double?
    let profilePath: String?
    let movies: [Movie]?
    
    enum CodingKeys: String, CodingKey {
        case adult, gender
        case id
        case role = "known_for_department"
        case name
        case originalName = "original_name"
        case popularity
        case profilePath = "profile_path"
        case movies = "known_for"
    }
}
