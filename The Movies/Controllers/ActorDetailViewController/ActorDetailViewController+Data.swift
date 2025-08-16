//
//  ActorDetailViewController+Data.swift
//  The Movies
//
//  Created by Paing Htet on 04/08/2025.
//

import Foundation

extension ActorDetailViewController {
    
//    func loadData() {
//        
//        // Fetch Actor Detail
//        actorModel.getActorDetail(actorId: actorId) { [weak self] result in
//            do {
//                self?.detail = try result.get()
//                self?.navigationItem.title = self?.detail?.name
//            } catch {
//                print("[Error: while fetching ActorDetail]", error)
//            }
//        }
//        
//        // Fetch Actor Credits
//        actorModel.getActorDetailForMovies(actorId: actorId) { [weak self] result in
//            do {
//                let response = try result.get()
//                response.movies?.forEach { self?.movies.append($0.convertToMovie()) }
//                self?.knownForCollectionView.reloadData()
//            } catch {
//                print("[Error: while fetching ActorCredits]", error)
//            }
//        }
//        
//    }
    
    func rxLoadData() {
        
        rxActorModel.getActorDetail(actorId: actorId)
            .subscribe { [weak self] response in
                self?.detail = response
                self?.navigationItem.title = self?.detail?.name
            } onError: { error in
                print("\(#function) \(error)")
            }
            .disposed(by: disposeBag)
        
        rxActorModel.getActorDetailForMovies(actorId: actorId)
            .compactMap { $0.movies }
            .subscribe { [weak self] movies in
                movies.forEach { self?.movies.append($0.convertToMovie()) }
                self?.knownForCollectionView.reloadData()
            } onError: { error in
                print("\(#function) \(error)")
            }
            .disposed(by: disposeBag)
    }
    
    
}
