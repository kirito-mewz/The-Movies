//
//  PopularMovieTableViewCell.swift
//  The Movies
//
//  Created by Paing Htet on 02/08/2025.
//

import UIKit

class PopularMovieTableViewCell: UITableViewCell {
    
    var movies: [Movie]? {
        didSet {
            popularMovieCollectionView.reloadData()
        }
    }
    
    @IBOutlet var sectionTitleLabel: UILabel!
    @IBOutlet var popularMovieCollectionView: UICollectionView!
    
    var delegate: MovieItemDelegate?
    
    override func awakeFromNib() {
        super.awakeFromNib()
        
        popularMovieCollectionView.delegate = self
        popularMovieCollectionView.dataSource = self
        
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }
    
}

extension PopularMovieTableViewCell: UICollectionViewDataSource, UICollectionViewDelegateFlowLayout {
    
    // UICollectionViewDataSource
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return movies?.count ?? 0
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueCell(ofType: MovieCollectionViewCell.self, for: indexPath, shouldRegister: true)
        cell.movie = movies?[indexPath.item]
        return cell
    }
    
    // UICollectionViewDelegateFlowLayout
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        return .init(width: collectionView.frame.width / 3, height: collectionView.frame.height)
    }
    
    // Delegate
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        if sectionTitleLabel.text!.lowercased().contains("movies") {
            delegate?.onMovieCellTapped(movieId: movies?[indexPath.row].id ?? 0, type: .movie)
        } else {
            delegate?.onMovieCellTapped(movieId: movies?[indexPath.row].id ?? 0, type: .tv)
        }
    }
}
