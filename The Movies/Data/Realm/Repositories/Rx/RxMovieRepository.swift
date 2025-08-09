//
//  RxMovieRepository.swift
//  The Movies
//
//  Created by Paing Htet on 10/08/2025.
//

import RxSwift
import RxRealm

protocol RxMovieRepository {
    
    func saveMovies(type: MovieDisplayType, pageNo: Int, movies: [Movie])
    func getMovies(type: MovieDisplayType, pageNo: Int) -> Observable<[Movie]>
    
    func saveMovieDetail(movieId id: Int, detail: MovieDetailResponse)
    func getMovieDetail(movieId id: Int) -> Observable<MovieDetailResponse>
    
}

final class RxMovieRepositoryImpl: BaseRepository, RxMovieRepository {
    
    static let shared: RxMovieRepository = RxMovieRepositoryImpl()
    
    private override init() {}
    
    func saveMovies(type: MovieDisplayType, pageNo: Int, movies: [Movie]) {
        let objects = movies.map { $0.convertToMovieObject(type: type) }
        do {
            try realm.write { realm.add(objects, update: .modified) }
        } catch {
            print("\(#function) \(error)")
        }
    }
    
    func getMovies(type: MovieDisplayType, pageNo: Int) -> RxSwift.Observable<[Movie]> {
        let predicate = NSPredicate(format: "displayType = %@ && pageNo = %d", type.rawValue, pageNo)
        let collection = realm.objects(MovieObject.self).filter(predicate).sorted(byKeyPath: "releaseDate")
        
        return Observable.collection(from: collection)
            .flatMap { objects -> Observable<[Movie]> in
                Observable.of(objects.map { $0.convertToMovie() })
            }
    }
    
    func saveMovieDetail(movieId id: Int, detail: MovieDetailResponse) {
        let detailObject = detail.convertToMovieDetailEmbeddedObject()
        do {
            try realm.write {
                let movie = realm.object(ofType: MovieObject.self, forPrimaryKey: id)
                movie?.detail = detailObject
            }
        } catch {
            print("\(#function) \(error)")
        }
    }
    
    func getMovieDetail(movieId id: Int) -> RxSwift.Observable<MovieDetailResponse> {
        let movieObject = realm.object(ofType: MovieObject.self, forPrimaryKey: id)
        return Observable.of((movieObject?.detail?.convertToMovieDetailResponse())!)
    }
    
    
}
