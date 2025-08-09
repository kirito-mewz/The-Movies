//
//  ActorRepository.swift
//  The Movies
//
//  Created by Paing Htet on 09/08/2025.
//

import RealmSwift

protocol ActorRepository {
    
    func saveActors(pageNo: Int, actors: [Actor])
    func getActors(pageNo: Int, completion: @escaping ([Actor]) -> Void)
    
    func saveActorDetail(actorId id: Int, detail: ActorDetailResponse)
    func getActorDetail(actorId id: Int, completion: @escaping (ActorDetailResponse) -> Void)
    
}

final class ActorRepositoryImpl: BaseRepository, ActorRepository {
    
    static let shared = ActorRepositoryImpl()
    
    private override init() {}
    
    func saveActors(pageNo: Int = 1, actors: [Actor]) {
        let actorObjects = actors.map { $0.convertToActorObject(pageNo: pageNo) }
        do {
            try realm.write {
                realm.add(actorObjects, update: .modified)
            }
        } catch {
            print("\(#function) \(error)")
        }
    }
    
    func getActors(pageNo: Int = 1, completion: @escaping ([Actor]) -> Void) {
        let predicate = NSPredicate(format: "pageNo = %d", pageNo)
        let objects: Results<ActorObject> = realm.objects(ActorObject.self).filter(predicate)
        completion(objects.map { $0.convertToActor() })
    }
    
    func saveActorDetail(actorId id: Int, detail: ActorDetailResponse) {
        if let actorObject = realm.object(ofType: ActorObject.self, forPrimaryKey: id) {
            do {
                try realm.write {
                    actorObject.detail = detail.convertToActorDetailObject()
                    realm.add(actorObject, update: .modified)
                }
            } catch {
                print("\(#function) \(error)")
            }
        }
    }
    
    func getActorDetail(actorId id: Int, completion: @escaping (ActorDetailResponse) -> Void) {
        if let detail = realm.object(ofType: ActorObject.self, forPrimaryKey: id)?.detail {
            completion(detail.convertToActorDetailResponse())
        }
    }
    
    
}
