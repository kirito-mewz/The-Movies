//
//  ActorObject.swift
//  The Movies
//
//  Created by Paing Htet on 09/08/2025.
//

import RealmSwift

// MARK: - ActorObject
class ActorObject: Object {
    
    @Persisted(primaryKey: true) var id: Int?
    @Persisted var adult: Bool?
    @Persisted var gender: Int?
    @Persisted var role: String?
    @Persisted var name: String?
    @Persisted var originalName: String?
    @Persisted var popularity: Double?
    @Persisted var profilePath: String?
    @Persisted var movies: List<MovieObject>
    @Persisted var detail: ActorDetailEmbeddedObject?
    @Persisted var pageNo: Int?
    
    func convertToActor() -> Actor {
        Actor(
            adult: adult,
            gender: gender,
            id: id,
            role: role,
            name: name,
            originalName: originalName,
            popularity: popularity,
            profilePath: profilePath,
            movies: movies.map { $0.convertToMovie() }
        )
    }
    
}

// MARK: - ActorDetailEmbeddedObject
class ActorDetailEmbeddedObject: EmbeddedObject {
    
    @Persisted var birthday: String?
    @Persisted var knownForDepartment: String?
    @Persisted var deathday: String?
    @Persisted var id: Int?
    @Persisted var name: String?
    @Persisted var alsoKnownAs: List<String>
    @Persisted var gender: Int?
    @Persisted var biography: String?
    @Persisted var popularity: Double?
    @Persisted var placeOfBirth: String?
    @Persisted var profilePath: String?
    @Persisted var adult: Bool?
    @Persisted var imdbId: String?
    @Persisted var homepage: String?
    
    func convertToActorDetailResponse() -> ActorDetailResponse {
        ActorDetailResponse(
            birthday: birthday,
            knownForDepartment: knownForDepartment,
            deathday: deathday,
            id: id,
            name: name,
            alsoKnownAs: alsoKnownAs.map { String($0) },
            gender: gender,
            biography: biography,
            popularity: popularity,
            placeOfBirth: placeOfBirth,
            profilePath: profilePath,
            adult: adult,
            imdbId: imdbId,
            homepage: homepage
        )
    }
    
}
