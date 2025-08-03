//
//  ActorModel.swift
//  The Movies
//
//  Created by Paing Htet on 03/08/2025.
//

import Foundation

protocol ActorModel {
    func getActors(pageNo: Int?, completion: @escaping (Result<ActorResponse, Error>) -> Void)
    func getActorDetail(actorId id: Int, completion: @escaping (Result<ActorDetailResponse, Error>) -> Void)
    func getActorDetailForMovies(actorId id: Int, completion: @escaping (Result<ActorCreditResponse, Error>) -> Void)
}

final class ActorModelImpl: BaseModel, ActorModel {
    
    static let shared: ActorModel = ActorModelImpl()
    
    private override init() {}
    
    func getActors(pageNo: Int?, completion: @escaping (Result<ActorResponse, any Error>) -> Void) {
        networkAgent.fetchActors(withEndpoint: .actors(pageNo: pageNo ?? 1)) { result in
            do {
                let response = try result.get()
                completion(.success(response))
            } catch {
                completion(.failure(error))
            }
        }
    }
    
    func getActorDetail(actorId id: Int, completion: @escaping (Result<ActorDetailResponse, any Error>) -> Void) {
        networkAgent.fetchActorDetail(actorId: id) { result in
            do {
                let response = try result.get()
                completion(.success(response))
            } catch {
                completion(.failure(error))
            }
        }
    }
    
    func getActorDetailForMovies(actorId id: Int, completion: @escaping (Result<ActorCreditResponse, any Error>) -> Void) {
        networkAgent.fetchActorDetailForMovies(actorId: id) { result in
            do {
                let response = try result.get()
                completion(.success(response))
            } catch {
                completion(.failure(error))
            }
        }
    }
    
    
}
