//
//  GenreRepository.swift
//  The Movies
//
//  Created by Paing Htet on 09/08/2025.
//

import RealmSwift

protocol GenreRepository {
    
    func saveGenres(genres: [Genre])
    func getGenres(completion: @escaping ([Genre]) -> Void)
    
}

final class GenreRepositoryImpl: BaseRepository, GenreRepository {
    
    static let shared = GenreRepositoryImpl()
    
    private override init() {}
    
    func saveGenres(genres: [Genre]) {
        let genreObjects = genres.map { $0.convertToGenreObject() }
        do {
            try realm.write {
                realm.add(genreObjects, update: .modified)
            }
        } catch {
            print("\(#function) \(error)")
        }
    }
    
    func getGenres(completion: @escaping ([Genre]) -> Void) {
        let objects: Results<GenreObject> = realm.objects(GenreObject.self)
        completion(objects.map { $0.convertToGenre() })
    }
    
    
}
