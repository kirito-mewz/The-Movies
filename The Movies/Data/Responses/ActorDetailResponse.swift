//
//  ActorDetailResponse.swift
//  The Movies
//
//  Created by Paing Htet on 03/08/2025.
//

import RealmSwift

// MARK: - ActorDetailResponse
struct ActorDetailResponse: Codable {
    let birthday, knownForDepartment: String?
    let deathday: String?
    let id: Int?
    let name: String?
    let alsoKnownAs: [String]?
    let gender: Int?
    let biography: String?
    let popularity: Double?
    let placeOfBirth, profilePath: String?
    let adult: Bool?
    let imdbId: String?
    let homepage: String?

    enum CodingKeys: String, CodingKey {
        case birthday
        case knownForDepartment = "known_for_department"
        case deathday, id, name
        case alsoKnownAs = "also_known_as"
        case gender, biography, popularity
        case placeOfBirth = "place_of_birth"
        case profilePath = "profile_path"
        case adult
        case imdbId = "imdb_id"
        case homepage
    }
    
    func convertToActorDetailObject() -> ActorDetailEmbeddedObject {
        
        let akaList = List<String>()
        alsoKnownAs?.forEach { akaList.append($0) }
        
        let object = ActorDetailEmbeddedObject()
        object.birthday = birthday
        object.knownForDepartment = knownForDepartment
        object.deathday = deathday
        object.id = id
        object.name = name
        object.alsoKnownAs = akaList
        object.gender = gender
        object.biography = biography
        object.popularity = popularity
        object.placeOfBirth = placeOfBirth
        object.profilePath = profilePath
        object.adult = adult
        object.imdbId = imdbId
        object.homepage = homepage
        return object
        
    }
    
}
