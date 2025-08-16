//
//  SearchViewController+Data.swift
//  The Movies
//
//  Created by Paing Htet on 04/08/2025.
//

import Foundation


extension SearchViewController {
    
//    func searchMovies(pageNo: Int = 1) {
//        movieModel.getSearchMovies(with: searchText, pageNo: pageNo) { [weak self]  result in
//            do {
//                let response = try result.get()
//                self?.totalPages = response.totalPages ?? 1
//                
//                if pageNo == 1 {
//                    self?.movies = response.movies
//                } else {
//                    self?.movies?.append(contentsOf: response.movies ?? [])
//                }
//                self?.collectionView.reloadData()
//            } catch {
//                print("[Error while fetch SearchMovies]", error)
//            }
//        }
//    }
    
    func rxSearchMovies(keyword: String, pageNo: Int) {
        rxMovieModel.getSearchMovies(with: keyword, pageNo: pageNo)
            .do { [weak self] items in
                self?.totalPages = items.totalPages ?? 1
            }
            .compactMap { $0.movies }
            .subscribe { movies in
                if self.currentPage == 1 {
                    self.searchResultItems.onNext(movies)
                } else {
                    self.searchResultItems.onNext(try! self.searchResultItems.value() + movies)
                }
            } onError: { error in
                print("\(#function) \(error)")
            }
            .disposed(by: disposeBag)
    }
    
}
