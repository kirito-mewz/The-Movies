//
//  MovieWithGenreTableViewCell.swift
//  The Movies
//
//  Created by Paing Htet on 02/08/2025.
//

import UIKit

class MovieWithGenreTableViewCell: UITableViewCell {
    
    @IBOutlet var genreCollectionView: UICollectionView!
    @IBOutlet var movieCollectionView: UICollectionView!
    
    fileprivate var genreList: [GenreVO] = [
        .init(id: 1, genreName: "ACTION", isSelected: true),
        .init(id: 2, genreName: "ADVENTURE", isSelected: false),
        .init(id: 3, genreName: "CRIMINAL", isSelected: false),
        .init(id: 4, genreName: "DRAMMA", isSelected: false),
        .init(id: 5, genreName: "COMEDY", isSelected: false),
        .init(id: 6, genreName: "DOCUMENTARY", isSelected: false),
        .init(id: 7, genreName: "BIOGRAPHY", isSelected: false)
    ]
    
    override func awakeFromNib() {
        super.awakeFromNib()
        
        genreCollectionView.delegate = self
        movieCollectionView.delegate = self
        
        genreCollectionView.dataSource = self
        movieCollectionView.dataSource = self
        
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }
    
}

extension MovieWithGenreTableViewCell: UICollectionViewDataSource, UICollectionViewDelegateFlowLayout {
    
    // UICollectionViewDataSource
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        if collectionView == genreCollectionView {
            return genreList.count
        } else {
            return 10
        }
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        if collectionView == genreCollectionView {
            return collectionView.dequeueCell(ofType: GenreCollectionViewCell.self, for: indexPath, shouldRegister: true) { [weak self] cell in
                guard let self = self else { return }
                // Pass data to the cell
                cell.data = self.genreList[indexPath.item]
                // Implement on tap event
                cell.onGenreTap = { genreId in
                    self.resetGenreSection(genreId)
                    self.genreCollectionView.reloadData()
                }
            }
        } else {
            return collectionView.dequeueCell(ofType: MovieCollectionViewCell.self, for: indexPath, shouldRegister: true)
        }
    }
    
    // UICollectionViewDelegateFlowLayout
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        if collectionView == genreCollectionView {
            let text = genreList[indexPath.row].genreName
            let textWidth = text.getWidth(of: UIFont(name: "Geeza Pro Bold", size: 14) ?? UIFont.systemFont(ofSize: 14))
            return .init(width: textWidth + 20, height: 40)
        } else {
            return .init(width: collectionView.frame.width / 3, height: collectionView.frame.height)
        }
    }
    
    fileprivate func resetGenreSection(_ genreId: Int) {
        genreList.forEach { genre in
            if genre.id == genreId {
                genre.isSelected = true
            } else {
                genre.isSelected = false
            }
        }
    }
    
}
