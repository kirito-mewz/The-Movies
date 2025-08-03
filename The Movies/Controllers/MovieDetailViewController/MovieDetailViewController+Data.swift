//
//  MovieDetailViewController+Data.swift
//  The Movies
//
//  Created by Paing Htet on 04/08/2025.
//

import Foundation

extension MovieDetailViewController {
    
    // Fetch Movie Detail
    func loadData() {
        movieModel.getMovieDetail(movieId: movidId, contentType: contentType) { [weak self] result in
            do {
                let detail = try result.get()
                self?.detail = detail
                self?.bindData(with: detail)
                self?.navigationItem.title = detail.title ?? detail.name
            } catch {
                print("[Error: while fetching MovieDetail]", error)
            }
        }
        fetchMovieCredits()
        fetchSimilarMovies()
    }
    
    // Fetch Movie Trailer
    func downloadTrailer() {
        movieModel.getMovieTrailer(movieId: movidId, contentType: contentType) { [weak self] result in
            do {
                let trailer = try result.get()
                let vc = YoutubePlayerViewController.instantiate()
                vc.keyPath = trailer.keyPath
                self?.present(vc, animated: true, completion: nil)
            } catch {
                print("[Error: while fetching MovieTrailer]", error)
            }
        }
    }
    
    // Fetch Movie Credits
    private func fetchMovieCredits() {
        movieModel.getMovieDetailForActors(movieId: movidId, contentType: contentType) { [weak self] result in
            do {
                self?.actors = try result.get()
                self?.actorsCollectionView.reloadData()
            } catch {
                print("[Error: while fetching MovieCreits]", error)
            }
        }
    }
    
    // Fetch Similar Movies
    private func fetchSimilarMovies() {
        movieModel.getMovieDetailForSimilarMovies(movieId: movidId, contentType: contentType) { [weak self] result in
            do {
                self?.similarMovies = try result.get().movies
                self?.similarMoviesCollectionView.reloadData()
            } catch {
                print("[Error: while fetching SimilarMovies]", error)
            }
        }
    }
    
}
