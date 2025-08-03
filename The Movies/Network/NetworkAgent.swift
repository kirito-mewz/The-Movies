//
//  NetworkAgent.swift
//  The Movies
//
//  Created by Paing Htet on 03/08/2025.
//

import Alamofire

protocol NetworkAgent {
    // MARK: - Main
    func fetchMovies(withEndpoint endpoint: MDBEndPoint, pageNo: Int, _ completion: @escaping (Result<MovieResponse, AFError>) -> Void)
    func fetchGenres(withEndpoint endpoint: MDBEndPoint, _ completion: @escaping (Result<Array<Genre>, AFError>) -> Void)
    func fetchShowcaseMovies(withEndpoint endpoint: MDBEndPoint, _ completion: @escaping (Result<MovieResponse, AFError>) -> Void)
    func fetchActors(withEndpoint endpoint: MDBEndPoint, _ completion: @escaping (Result<ActorResponse, AFError>) -> Void)
    func fetchSearchMovies(with keyword: String, pageNo: Int, _ completion: @escaping (Result<MovieResponse, AFError>) -> Void)
    
    // MARK: - Movie Detail
    func fetchMovieDetail(movieId id: Int, contentType: MovieFetchType, _ completion: @escaping (Result<MovieDetailResponse, AFError>) -> Void)
    func fetchMovieTrailer(movieId id: Int, contentType: MovieFetchType, _ completion: @escaping (Result<Trailer, AFError>) -> Void)
    func fetchMovieDetailForActors(movieId id: Int, contentType: MovieFetchType, _ completion: @escaping (Result<Array<Actor>, AFError>) -> Void)
    func fetchMovieDetailForSimilarMovies(movieId id: Int, contentType: MovieFetchType,_ completion: @escaping (Result<MovieResponse, AFError>) -> Void)
    
    // MARK: - Actor Detail
    func fetchActorDetail(actorId id: Int, _ completion: @escaping (Result<ActorDetailResponse, AFError>) -> Void)
    func fetchActorDetailForMovies(actorId id: Int, _ completion: @escaping (Result<ActorCreditResponse, AFError>) -> Void)

}
