//
//  RxGenreRepository.swift
//  The Movies
//
//  Created by Paing Htet on 10/08/2025.
//

import RxSwift
import RxRealm
import RealmSwift

protocol RxGenreRepository {
    
    func saveGenres(genres: [Genre])
    func getGenres() -> Observable<[Genre]>
    
}

final class RxGenreRepositoryImpl: BaseRepository, RxGenreRepository {
    
    static let shared: RxGenreRepository = RxGenreRepositoryImpl()
    
    private override init() {}
    
    func saveGenres(genres: [Genre]) {
        let objects = genres.map { $0.convertToGenreObject() }
        do {
            try realm.write { realm.add(objects, update: .modified) }
        } catch {
            print("\(#function) \(error)")
        }
    }
    
    func getGenres() -> RxSwift.Observable<[Genre]> {
        let collection: Results<GenreObject> = realm.objects(GenreObject.self)
        return Observable.collection(from: collection)
            .flatMap { objects -> Observable<[Genre]> in
                return Observable.of(objects.map { $0.convertToGenre()})
            }
    }
    
    
    
    
}
