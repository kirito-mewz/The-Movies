//
//  RxActorModel.swift
//  The Movies
//
//  Created by Paing Htet on 10/08/2025.
//

import RxSwift

protocol RxActorModel {
    
    func getActors(pageNo: Int?) -> Observable<ActorResponse>
    func getActorDetail(actorId id: Int) -> Observable<ActorDetailResponse>
    func getActorDetailForMovies(actorId id: Int) -> Observable<ActorCreditResponse>
    
}

final class RxActorModelImpl: BaseModel, RxActorModel {
    
    static let shared: RxActorModel = RxActorModelImpl()
    
    private let rxActorRepo: RxActorRepository = RxActorRepositoryImpl.shared
    private let rxMovieRepo: RxMovieRepository = RxMovieRepositoryImpl.shared
    
    private override init() {}
    
    func getActors(pageNo: Int?) -> RxSwift.Observable<ActorResponse> {
        rxNetworkAgent.fetchActors(withEndpoint: .actors(pageNo: pageNo ?? 1))
            .do { [weak self] response in
                self?.rxActorRepo.saveActors(pageNo: pageNo ?? 1, actors: response.actors ?? [])
            } onError: { error in
                print("\(#function) \(error)")
            }
            .flatMap { response -> Observable<ActorResponse> in
                self.rxActorRepo.getActors(pageNo: pageNo ?? 1)
                    .flatMap { actors in
                        return Observable.of(ActorResponse(page: response.page, actors: actors, totalPages: response.totalPages, totalResults: response.totalResults))
                    }
            }
    }
    
    func getActorDetail(actorId id: Int) -> RxSwift.Observable<ActorDetailResponse> {
        rxNetworkAgent.fetchActorDetail(actorId: id)
            .do { [weak self] response in
                self?.rxActorRepo.saveActorDetail(actorId: id, detail: response)
            } onError: { error in
                print("\(#function) \(error)")
            }
            .flatMap { response -> Observable<ActorDetailResponse> in
                self.rxActorRepo.getActorDetail(actorId: response.id ?? -1)
            }
    }
    
    func getActorDetailForMovies(actorId id: Int) -> RxSwift.Observable<ActorCreditResponse> {
        rxNetworkAgent.fetchActorDetailForMovies(actorId: id)
    }
    
    
    
    
}
