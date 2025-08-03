//
//  ActorDetailViewController+Data.swift
//  The Movies
//
//  Created by Paing Htet on 04/08/2025.
//

import Foundation

extension ActorDetailViewController {
    
    func loadData() {
        
        // Fetch Actor Detail
        actorModel.getActorDetail(actorId: actorId) { [weak self] result in
            do {
                self?.detail = try result.get()
                self?.navigationItem.title = self?.detail?.name
            } catch {
                print("[Error: while fetching ActorDetail]", error)
            }
        }
        
        // Fetch Actor Credits
        actorModel.getActorDetailForMovies(actorId: actorId) { [weak self] result in
            do {
                let response = try result.get()
                response.movies?.forEach { self?.movies.append($0.convertToMovie()) }
                self?.knownForCollectionView.reloadData()
            } catch {
                print("[Error: while fetching ActorCredits]", error)
            }
        }
        
    }
    
}
