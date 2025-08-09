//
//  RxNetworkAgent.swift
//  The Movies
//
//  Created by Paing Htet on 10/08/2025.
//

import RxSwift
import RxAlamofire

protocol RxNetworkAgent {
    
    // MARK: - Main
    func fetchMovies(withEndpoint endpoint: MDBEndPoint) -> Observable<MovieResponse>
    func fetchGenres(withEndpoint endpoint: MDBEndPoint) -> Observable<[Genre]>
    func fetchShowcaseMovies(withEndpoint endpoint: MDBEndPoint) -> Observable<MovieResponse>
    func fetchActors(withEndpoint endpoint: MDBEndPoint) -> Observable<ActorResponse>
    func fetchSearchMovies(with keyword: String, pageNo: Int) -> Observable<MovieResponse>
    
    // MARK: - Movie Detail
    func fetchMovieDetail(movieId id: Int, contentType: MovieFetchType) -> Observable<MovieDetailResponse>
    func fetchMovieTrailer(movieId id: Int, contentType: MovieFetchType) -> Observable<Trailer>
    func fetchMovieDetailForActors(movieId id: Int, contentType: MovieFetchType) -> Observable<[Actor]>
    func fetchMovieDetailForSimilarMovies(movieId id: Int, contentType: MovieFetchType) -> Observable<MovieResponse>
    
    // MARK: - Actor Detail
    func fetchActorDetail(actorId id: Int) -> Observable<ActorDetailResponse>
    func fetchActorDetailForMovies(actorId id: Int) -> Observable<ActorCreditResponse>

}

class RxNetworkAgentImpl: RxNetworkAgent {
    
    static let shared: RxNetworkAgent = RxNetworkAgentImpl()
    
    private init() {}
    
    func fetchMovies(withEndpoint endpoint: MDBEndPoint) -> RxSwift.Observable<MovieResponse> {
        RxAlamofire.requestDecodable(endpoint)
            .flatMap { Observable.just($0.1) }
    }
    
    func fetchGenres(withEndpoint endpoint: MDBEndPoint) -> RxSwift.Observable<[Genre]> {
        RxAlamofire.requestDecodable(endpoint)
            .compactMap { tuple -> MovieGenre in
                tuple.1
            }
            .flatMap { movieGenres in
                Observable.just(movieGenres.genres ?? [])
            }
    }
    
    func fetchShowcaseMovies(withEndpoint endpoint: MDBEndPoint) -> RxSwift.Observable<MovieResponse> {
        RxAlamofire.requestDecodable(endpoint)
            .flatMap { Observable.just($0.1) }
    }
    
    func fetchActors(withEndpoint endpoint: MDBEndPoint) -> RxSwift.Observable<ActorResponse> {
        RxAlamofire.requestDecodable(endpoint)
            .flatMap { Observable.just($0.1) }
    }
    
    func fetchSearchMovies(with keyword: String, pageNo: Int) -> RxSwift.Observable<MovieResponse> {
        let whiteSpaceReplacedStr: String = keyword.replacingOccurrences(of: " ", with: "+")
        return RxAlamofire.requestDecodable(MDBEndPoint.searchMovies(keyword: whiteSpaceReplacedStr))
            .flatMap { Observable.just($0.1) }
    }
    
    func fetchMovieDetail(movieId id: Int, contentType: MovieFetchType) -> RxSwift.Observable<MovieDetailResponse> {
        RxAlamofire.requestDecodable(MDBEndPoint.movieDetail(movieId: id, contentType: contentType))
            .flatMap { Observable.just($0.1) }
    }
    
    func fetchMovieTrailer(movieId id: Int, contentType: MovieFetchType) -> RxSwift.Observable<Trailer> {
        RxAlamofire.requestDecodable(MDBEndPoint.movieTrailer(movieId: id, contetntType: contentType))
            .flatMap { Observable.just($0.1) }
    }
    
    func fetchMovieDetailForActors(movieId id: Int, contentType: MovieFetchType) -> RxSwift.Observable<[Actor]> {
        RxAlamofire.requestDecodable(MDBEndPoint.movieDetailForActors(movieId: id, contentType: contentType))
            .do { response in
                print(response)
            } onError: { error in
                print("\(#function) \(error)")
            }
            .map { tuple -> MovieCreditResponse in
                return tuple.1
            }
            .flatMap { movieCreditResponse in
                return Observable.of(movieCreditResponse.convertToActor() ?? [Actor]())
            }
    }
    
    func fetchMovieDetailForSimilarMovies(movieId id: Int, contentType: MovieFetchType) -> RxSwift.Observable<MovieResponse> {
        RxAlamofire.requestDecodable(MDBEndPoint.movieDetailForSimilarMovies(movieId: id, contentType: contentType))
            .flatMap { Observable.just($0.1) }
    }
    
    func fetchActorDetail(actorId id: Int) -> RxSwift.Observable<ActorDetailResponse> {
        RxAlamofire.requestDecodable(MDBEndPoint.actorDetail(actorId: id))
            .flatMap { Observable.just($0.1) }
    }
    
    func fetchActorDetailForMovies(actorId id: Int) -> RxSwift.Observable<ActorCreditResponse> {
        RxAlamofire.requestDecodable(MDBEndPoint.actorDetailForMovies(actorId: id))
            .flatMap { Observable.just($0.1) }
    }
    
    
}
