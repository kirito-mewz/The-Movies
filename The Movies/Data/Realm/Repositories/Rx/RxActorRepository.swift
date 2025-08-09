//
//  RxActorRepository.swift
//  The Movies
//
//  Created by Paing Htet on 10/08/2025.
//

import RxSwift
import RxRealm
import RealmSwift

protocol RxActorRepository {
    
    func saveActors(pageNo: Int, actors: [Actor])
    func getActors(pageNo: Int) -> Observable<[Actor]>
    
    func saveActorDetail(actorId id: Int, detail: ActorDetailResponse)
    func getActorDetail(actorId id: Int) -> Observable<ActorDetailResponse>
    
}


final class RxActorRepositoryImpl: BaseRepository, RxActorRepository {
    
    static let shared: RxActorRepository = RxActorRepositoryImpl()
    private var disposeBag = DisposeBag()
    
    private override init() {}
    
    func saveActors(pageNo: Int, actors: [Actor]) {
        let objects = actors.map { $0.convertToActorObject(pageNo: pageNo) }
        Observable.from(objects)
            .subscribe(realm.rx.add(update: .modified))
            .disposed(by: disposeBag)
    }
    
    func getActors(pageNo: Int) -> RxSwift.Observable<[Actor]> {
        let collection: Results<ActorObject> = realm.objects(ActorObject.self)
        return Observable.collection(from: collection)
            .flatMap { objects -> Observable<[Actor]> in
                Observable.of(objects.map { $0.convertToActor() })
            }
    }
    
    func saveActorDetail(actorId id: Int, detail: ActorDetailResponse) {
        if let detailObject = realm.object(ofType: ActorObject.self, forPrimaryKey: id) {
            try? realm.write {
                detailObject.detail = detail.convertToActorDetailObject()
            }
        } else {
            let object = ActorObject()
            object.id = detail.id ?? -1
            object.detail = detail.convertToActorDetailObject()
            
            try? realm.write {
                realm.add(object, update: .modified)
            }
        }
    }
    
    func getActorDetail(actorId id: Int) -> RxSwift.Observable<ActorDetailResponse> {
        let actorObject = realm.object(ofType: ActorObject.self, forPrimaryKey: id)!
        return Observable.from(object: actorObject)
            .compactMap { $0.detail }
            .flatMap { detail in
                Observable.of(detail.convertToActorDetailResponse())
            }
    }
    
    
}
