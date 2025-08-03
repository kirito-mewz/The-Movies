//
//  SearchViewController+Data.swift
//  The Movies
//
//  Created by Paing Htet on 04/08/2025.
//

import Foundation


extension SearchViewController {
    
    func searchMovies(pageNo: Int = 1) {
        movieModel.getSearchMovies(with: searchText, pageNo: pageNo) { [weak self]  result in
            do {
                let response = try result.get()
                self?.totalPages = response.totalPages ?? 1
                
                if pageNo == 1 {
                    self?.movies = response.movies
                } else {
                    self?.movies?.append(contentsOf: response.movies ?? [])
                }
                self?.collectionView.reloadData()
            } catch {
                print("[Error while fetch SearchMovies]", error)
            }
        }
    }
    
}
