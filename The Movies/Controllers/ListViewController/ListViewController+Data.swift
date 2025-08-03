//
//  ListViewController+Data.swift
//  The Movies
//
//  Created by Paing Htet on 04/08/2025.
//

import Foundation

extension ListViewController {
    
    func loadNextPageData(pageNo: Int) {
        if type == .movies {
            loadMovies(pageNo: pageNo)
        } else {
            loadActors(pageNo: pageNo)
        }
    }
    
    private func loadMovies(pageNo: Int) {
        movieModel.getShowcaseMovies(pageNo: pageNo) { [weak self] result in
            do {
                let response = try result.get()
                response.movies?.forEach { self?.movies.append($0) }
                self?.collectionView.reloadData()
                self?.currentPage += 1
            } catch {
                print("[Error: while fetching Actors]", error)
            }
        }
    }
    
    private func loadActors(pageNo: Int) {
        actorModel.getActors(pageNo: pageNo) { [weak self] result in
            do {
                let response = try result.get()
                response.actors?.forEach { self?.actors.append($0) }
                self?.collectionView.reloadData()
                self?.currentPage += 1
            } catch {
                print("[Error: while fetching top rated movies]", error)
            }
        }
    }
    
}
