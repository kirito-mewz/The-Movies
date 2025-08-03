//
//  SearchViewController+Delegates.swift
//  The Movies
//
//  Created by Paing Htet on 04/08/2025.
//

import UIKit

extension SearchViewController: UICollectionViewDataSource, UICollectionViewDelegateFlowLayout {

    // UICollectionViewDataSource
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return movies?.count ?? 0
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueCell(ofType: MovieCollectionViewCell.self, for: indexPath, shouldRegister: true)
        cell.movie = movies?[indexPath.row]
        return cell
    }
    
    // UICollectionViewDelegateFlowLayout
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        let width = (collectionView.frame.width - 20 - ((noOfCols - 1) * spacing)) / noOfCols
        return CGSize(width: width, height: 250)
    }
    
    
    // Display UpButton while scrolling
    func scrollViewDidScroll(_ scrollView: UIScrollView) {
        if scrollView.contentOffset.y > scrollView.frame.height / 2 {
            upButton.isHidden = false
            UIView.animate(withDuration: 0.5) { [weak self] in
                self?.upButton.transform = .identity
            }
        } else {
            if upButton.transform.isIdentity {
                UIView.animate(withDuration: 0.5) { [weak self] in
                    self?.upButton.transform = CGAffineTransform(scaleX: 0.001, y: 0.001)
                }
            }
        }
    }
    
    // Loading movies while scrolling
    func collectionView(_ collectionView: UICollectionView, willDisplay cell: UICollectionViewCell, forItemAt indexPath: IndexPath) {
        let lastRow = indexPath.row == (movies?.count ?? 0) - 1
        if lastRow && currentPage <= totalPages {
            currentPage += 1
            searchMovies(pageNo: currentPage)
        }
    }
    
    // Delegate
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        self.onMovieCellTapped(movieId: movies?[indexPath.row].id, type: .movie)
    }
    
}

// MARK: - Custom Delegate
extension SearchViewController: MovieItemDelegate, ActorItemDelegate {
    func onFavouriteTapped(isFavourite: Bool) {
        // Todo
    }
}
