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
    private let actorRepository: ActorRepository = ActorRepositoryImpl.shared
    
    private override init() {}
    
    func getActors(pageNo: Int?, completion: @escaping (Result<ActorResponse, any Error>) -> Void) {
        networkAgent.fetchActors(withEndpoint: .actors(pageNo: pageNo ?? 1)) { [weak self] result in
            do {
                let response = try result.get()
                
                self?.actorRepository.saveActors(pageNo: pageNo ?? 1, actors: response.actors ?? [])
                self?.actorRepository.getActors(pageNo: pageNo ?? 1) { actors in
                    completion(.success(
                        ActorResponse(page: response.page, actors: actors, totalPages: response.totalPages, totalResults: response.totalResults)
                    ))
                }
                
            } catch {
                completion(.failure(error))
            }
        }
    }
    
    func getActorDetail(actorId id: Int, completion: @escaping (Result<ActorDetailResponse, any Error>) -> Void) {
        networkAgent.fetchActorDetail(actorId: id) { [weak self] result in
            do {
                let response = try result.get()
                
                self?.actorRepository.saveActorDetail(actorId: id, detail: response)
                self?.actorRepository.getActorDetail(actorId: id) { detail in
                    completion(.success(detail))
                }
                
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
