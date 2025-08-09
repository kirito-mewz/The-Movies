//
//  ActorResponse.swift
//  The Movies
//
//  Created by Paing Htet on 03/08/2025.
//

import RealmSwift

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
    
    func convertToActorObject(pageNo: Int) -> ActorObject {
        
        let movieObject = List<MovieObject>()
        movies?.map { $0.convertToMovieObject(type: .others) }.forEach { movieObject.append($0) }
        
        let object = ActorObject()
        object.adult = adult
        object.gender = gender
        object.id = id
        object.role = role
        object.name = name
        object.originalName = originalName
        object.popularity = popularity
        object.profilePath = profilePath
        object.movies = movieObject
        object.pageNo = pageNo
        return object
        
    }
}
