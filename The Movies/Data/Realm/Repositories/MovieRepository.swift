//
//  MovieRepository.swift
//  The Movies
//
//  Created by Paing Htet on 09/08/2025.
//

import RealmSwift

protocol MovieRepository {
    
    func saveMovies(type: MovieDisplayType, pageNo: Int, movies: [Movie])
    func getMovies(type: MovieDisplayType, pageNo: Int, _ completion: @escaping ([Movie]) -> Void)
    
    func saveMovieDetail(movieId id: Int, detail: MovieDetailResponse)
    func getMovieDetail(movieId id: Int, _ completion: @escaping (MovieDetailResponse) -> Void)
    
}

final class MovieRepositoryImpl: BaseRepository, MovieRepository {
    
    static let shared = MovieRepositoryImpl()
    
    private override init() {}
    
    func saveMovies(type: MovieDisplayType, pageNo: Int = 1, movies: [Movie]) {
        let movieObjects = movies.map { $0.convertToMovieObject(type: type, pageNo: pageNo) }
        do {
            try realm.write {
                realm.add(movieObjects, update: .modified)
            }
        } catch {
            print("\(#function) \(error)")
        }
    }
    
    func getMovies(type: MovieDisplayType, pageNo: Int = 1, _ completion: @escaping ([Movie]) -> Void) {
        let predicate = NSPredicate(format: "displayType = %@ && pageNo = %d", type.rawValue, pageNo)
        let objects: Results<MovieObject> = realm.objects(MovieObject.self).filter(predicate)
        completion(objects.map { $0.convertToMovie() })
    }
    
    func saveMovieDetail(movieId id: Int, detail: MovieDetailResponse) {
        if let movieObject = realm.object(ofType: MovieObject.self, forPrimaryKey: id) {
            do {
                try realm.write {
                    movieObject.detail = detail.convertToMovieDetailEmbeddedObject()
                    realm.add(movieObject, update: .modified)
                }
            } catch {
                print("\(#function) \(error)")
            }
        }
    }
    
    func getMovieDetail(movieId id: Int, _ completion: @escaping (MovieDetailResponse) -> Void) {
        if let detail = realm.object(ofType: MovieObject.self, forPrimaryKey: id)?.detail {
            completion(detail.convertToMovieDetailResponse())
        }
    }
    
    
}
