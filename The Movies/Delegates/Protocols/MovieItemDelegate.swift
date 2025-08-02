//
//  MovieItemDelegate.swift
//  The Movies
//
//  Created by Paing Htet on 02/08/2025.
//

import UIKit

protocol MovieItemDelegate {
    func onMovieCellTapped()
}

extension MovieItemDelegate where Self: UIViewController {
    func onMovieCellTapped() {
        let vc = MovieDetailViewController.instantiate()
        (self as UIViewController).navigationController?.pushViewController(vc, animated: true)
    }
}
