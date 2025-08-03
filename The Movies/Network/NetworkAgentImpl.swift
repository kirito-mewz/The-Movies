//
//  NetworkAgentImpl.swift
//  The Movies
//
//  Created by Paing Htet on 03/08/2025.
//

import Alamofire

final class NetworkAgentImpl: NetworkAgent {
    
    static let shared: NetworkAgentImpl = NetworkAgentImpl()
    
    private init() {}
    
    // Main
    func fetchMovies(withEndpoint endpoint: MDBEndPoint, pageNo: Int, _ completion: @escaping (Result<MovieResponse, Alamofire.AFError>) -> Void) {
        AF.request(endpoint.urlString).responseDecodable(of: MovieResponse.self) { response in
            if let error = response.error {
                completion(.failure(error))
            }
            if let response = response.value {
                completion(.success(response))
            }
        }.validate(statusCode: 200..<300)
    }
    
    func fetchGenres(withEndpoint endpoint: MDBEndPoint, _ completion: @escaping (Result<Array<Genre>, Alamofire.AFError>) -> Void) {
        AF.request(endpoint.urlString).responseDecodable(of: MovieGenre.self) { response in
            if let error = response.error {
                completion(.failure(error))
            }
            if let response = response.value, let genres = response.genres {
                completion(.success(genres))
            }
        }.validate(statusCode: 200..<300)
    }
    
    func fetchShowcaseMovies(withEndpoint endpoint: MDBEndPoint, _ completion: @escaping (Result<MovieResponse, Alamofire.AFError>) -> Void) {
        AF.request(endpoint.urlString).responseDecodable(of: MovieResponse.self) { response in
            if let error = response.error {
                completion(.failure(error))
            }
            if let response = response.value {
                completion(.success(response))
            }
        }.validate(statusCode: 200..<300)
    }
    
    func fetchActors(withEndpoint endpoint: MDBEndPoint, _ completion: @escaping (Result<ActorResponse, Alamofire.AFError>) -> Void) {
        AF.request(endpoint.urlString).responseDecodable(of: ActorResponse.self) { response in
            if let error = response.error {
                completion(.failure(error))
            }
            if let response = response.value {
                completion(.success(response))
            }
        }.validate(statusCode: 200..<300)
    }
    
    func fetchSearchMovies(with keyword: String, pageNo: Int, _ completion: @escaping (Result<MovieResponse, Alamofire.AFError>) -> Void) {
        let urlString = MDBEndPoint.searchMovies(keyword: keyword).urlString
        AF.request(urlString).responseDecodable(of: MovieResponse.self) { response in
            if let error = response.error {
                completion(.failure(error))
            }
            if let response = response.value {
                completion(.success(response))
            }
        }.validate(statusCode: 200..<300)
    }
    
    // Movie Detail
    func fetchMovieDetail(movieId id: Int, contentType: MovieFetchType, _ completion: @escaping (Result<MovieDetailResponse, Alamofire.AFError>) -> Void) {
        let urlString = MDBEndPoint.movieDetail(movieId: id, contentType: contentType).urlString
        AF.request(urlString).responseDecodable(of: MovieDetailResponse.self) { response in
            if let error = response.error {
                completion(.failure(error))
            }
            if let response = response.value {
                completion(.success(response))
            }
        }.validate(statusCode: 200..<300)
    }
    
    func fetchMovieTrailer(movieId id: Int, contentType: MovieFetchType, _ completion: @escaping (Result<Trailer, Alamofire.AFError>) -> Void) {
        let urlString = MDBEndPoint.movieTrailer(movieId: id, contetntType: contentType).urlString
        AF.request(urlString).responseDecodable(of: MovieTrailerResponse.self) { response in
            if let error = response.error {
                completion(.failure(error))
            }
            if let response = response.value, let trailer = response.results?.first {
                completion(.success(trailer))
            }
        }.validate(statusCode: 200..<300)
    }
    
    func fetchMovieDetailForActors(movieId id: Int, contentType: MovieFetchType, _ completion: @escaping (Result<Array<Actor>, Alamofire.AFError>) -> Void) {
        let urlString = MDBEndPoint.movieDetailForActors(movieId: id, contentType: contentType).urlString
        AF.request(urlString).responseDecodable(of: MovieCreditResponse.self) { response in
            if let error = response.error {
                completion(.failure(error))
            }
            if let response = response.value, let actors = response.convertToActor() {
                completion(.success(actors))
            }
        }.validate(statusCode: 200..<300)
    }
    
    func fetchMovieDetailForSimilarMovies(movieId id: Int, contentType: MovieFetchType, _ completion: @escaping (Result<MovieResponse, Alamofire.AFError>) -> Void) {
        let urlString = MDBEndPoint.movieDetailForSimilarMovies(movieId: id, contentType: contentType).urlString
        AF.request(urlString).responseDecodable(of: MovieResponse.self) { response in
            if let error = response.error {
                completion(.failure(error))
            }
            if let response = response.value {
                completion(.success(response))
            }
        }.validate(statusCode: 200..<300)
    }
    
    // Actor Detail
    func fetchActorDetail(actorId id: Int, _ completion: @escaping (Result<ActorDetailResponse, Alamofire.AFError>) -> Void) {
        let urlString = MDBEndPoint.actorDetail(actorId: id).urlString
        AF.request(urlString).responseDecodable(of: ActorDetailResponse.self) { response in
            if let error = response.error {
                completion(.failure(error))
            }
            if let response = response.value {
                completion(.success(response))
            }
        }.validate(statusCode: 200..<300)
    }
    
    func fetchActorDetailForMovies(actorId id: Int, _ completion: @escaping (Result<ActorCreditResponse, Alamofire.AFError>) -> Void) {
        let urlString = MDBEndPoint.actorDetailForMovies(actorId: id).urlString
        AF.request(urlString).responseDecodable(of: ActorCreditResponse.self) { response in
            if let error = response.error {
                completion(.failure(error))
            }
            if let response = response.value {
                completion(.success(response))
            }
        }.validate(statusCode: 200..<300)
    }
     
}
