//
//  GenreObject.swift
//  The Movies
//
//  Created by Paing Htet on 09/08/2025.
//

import RealmSwift

class GenreObject: Object {
    
    @Persisted(primaryKey: true) var id: Int?
    @Persisted var name: String?
    
    func convertToGenre() -> Genre {
        Genre(id: id, name: name)
    }
    
}
