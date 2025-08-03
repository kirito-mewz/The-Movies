//
//  MovieDetailViewController+Delegates.swift
//  The Movies
//
//  Created by Paing Htet on 04/08/2025.
//

import UIKit

extension MovieDetailViewController: UICollectionViewDataSource, UICollectionViewDelegateFlowLayout {
    
    // UICollectionViewDataSource
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        if collectionView == badgeCollectionView {
            return detail?.genres?.count ?? 0
        } else if collectionView == actorsCollectionView {
            return actors?.count ?? 0
        } else if collectionView == companiesCollectionView {
            return companies?.count ?? 0
        } else {
            return similarMovies?.count ?? 0
        }
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        if collectionView == badgeCollectionView {
            let cell = collectionView.dequeueCell(ofType: GenreBadgeCollectionViewCell.self, for: indexPath, shouldRegister: true)
            cell.genre = detail?.genres?[indexPath.row]
            return cell
        } else if collectionView == actorsCollectionView {
            let cell = collectionView.dequeueCell(ofType: ActorCollectionViewCell.self, for: indexPath, shouldRegister: true)
            cell.delegate = self
            cell.actor = actors?[indexPath.row]
            return cell
        } else if collectionView == companiesCollectionView {
            let cell = collectionView.dequeueCell(ofType: CompanyCollectionViewCell.self, for: indexPath, shouldRegister: true)
            cell.company = companies?[indexPath.row]
            return cell
        } else {
            let cell = collectionView.dequeueCell(ofType: MovieCollectionViewCell.self, for: indexPath, shouldRegister: true)
            cell.movie = similarMovies?[indexPath.row]
            return cell
        }
    }
    
    // UICollectionViewDelegateFlowLayout
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        if collectionView == badgeCollectionView {
            let text = detail?.genres?[indexPath.row].name ?? ""
            let textWidth = text.getWidth(of: UIFont(name: "Geeza Pro Bold", size: 14) ?? UIFont.systemFont(ofSize: 14))
            return .init(width: textWidth + 26, height: collectionView.frame.height)
        } else if collectionView == actorsCollectionView {
            return .init(width: collectionView.frame.width * 0.35, height: collectionView.frame.height)
        } else if collectionView == companiesCollectionView {
            let width: CGFloat = 150
            return .init(width: width, height: width - 50)
        } else {
            return .init(width: collectionView.frame.width / 3, height: collectionView.frame.height)
        }
    }
    
    // Delegate
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        if collectionView == similarMoviesCollectionView {
            self.onMovieCellTapped(movieId: similarMovies?[indexPath.row].id ?? 0, type: contentType)
        } else if collectionView == actorsCollectionView {
            self.onActorCellTapped(actorId: actors?[indexPath.row].id ?? 0)
        }
    }
    
}

// MARK: - Custom Delegate
extension MovieDetailViewController: MovieItemDelegate, ActorItemDelegate {
    func onFavouriteTapped(isFavourite: Bool) {
        // Todo
    }
}
