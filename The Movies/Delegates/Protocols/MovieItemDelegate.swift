//
//  MovieItemDelegate.swift
//  The Movies
//
//  Created by Paing Htet on 02/08/2025.
//

import UIKit

protocol MovieItemDelegate {
    func onMovieCellTapped(movieId: Int?, type: MovieFetchType)
}

extension MovieItemDelegate where Self: UIViewController {
    func onMovieCellTapped(movieId: Int?, type: MovieFetchType = .movie) {
        let vc = MovieDetailViewController.instantiate()
        vc.movieId = movieId ?? -1
        vc.contentType = type
        (self as UIViewController).navigationController?.pushViewController(vc, animated: true)
    }
}
