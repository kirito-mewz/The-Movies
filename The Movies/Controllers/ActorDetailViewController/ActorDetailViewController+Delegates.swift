//
//  ActorDetailViewController+Delegates.swift
//  The Movies
//
//  Created by Paing Htet on 04/08/2025.
//

import UIKit

extension ActorDetailViewController: UICollectionViewDataSource, UICollectionViewDelegateFlowLayout {
    
    // UICollectionViewDataSource
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return movies.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueCell(ofType: MovieCollectionViewCell.self, for: indexPath, shouldRegister: true)
        cell.movie = movies[indexPath.row]
        return cell
    }
    
    // UICollectionViewDelegateFlowLayout
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        return .init(width: collectionView.frame.width / 3, height: collectionView.frame.height)
    }
    
    // Delegate
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        let movie = movies[indexPath.row]
        self.onMovieCellTapped(movieId: movie.id, type: (movie.mediaType ?? "movie") == "movie" ? .movie : .tv)
    }
    
}

// MARK: - Custom Delegate
extension ActorDetailViewController: MovieItemDelegate, ActorItemDelegate {
    func onFavouriteTapped(isFavourite: Bool) {
        // Todo
    }
}
