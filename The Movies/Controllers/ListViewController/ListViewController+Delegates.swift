//
//  ListViewController+Delegates.swift
//  The Movies
//
//  Created by Paing Htet on 04/08/2025.
//

import UIKit

extension ListViewController: UICollectionViewDataSource, UICollectionViewDelegateFlowLayout {
    
    // UICollectionViewDataSource
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return type == .movies ? movies.count : actors.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        if type == .movies {
            let cell = collectionView.dequeueCell(ofType: ShowcaseCollectionViewCell.self, for: indexPath, shouldRegister: true)
            cell.movie = movies[indexPath.row]
            return cell
        } else {
            let cell = collectionView.dequeueCell(ofType: ActorCollectionViewCell.self, for: indexPath, shouldRegister: true)
            cell.actor = actors[indexPath.row]
            return cell
        }
    }
    
    // UICollectionViewDelegateFlowLayout
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        if type == .movies {
            let width = collectionView.frame.width - 20
            let height = (width * 9) / 16
            return .init(width: width, height: height)
        } else {
            let width = (collectionView.frame.width - 20 - ((noOfCols - 1) * spacing)) / noOfCols
            let height = width + width * 0.5
            return .init(width: width, height: height)
        }
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
        let lastRow = indexPath.row == (type == .movies ? movies.count - 1 : actors.count - 1)
        if lastRow && currentPage <= totalPages {
            loadNextPageData(pageNo: currentPage + 1)
        }
    }
    
    // Delegate
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        if type == .movies {
            self.onMovieCellTapped(movieId: movies[indexPath.row].id, type: .movie)
        } else {
            self.onActorCellTapped(actorId: actors[indexPath.row].id)
        }
    }
    
}

// MARK: - Custom Delegate
extension ListViewController: MovieItemDelegate, ActorItemDelegate {
    func onFavouriteTapped(isFavourite: Bool) {
        // Todo
    }
}
