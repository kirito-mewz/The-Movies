//
//  MovieWithGenreTableViewCell.swift
//  The Movies
//
//  Created by PaingHtet on 21/06/2025.
//

import UIKit

class MovieWithGenreTableViewCell: UITableViewCell {
    
    @IBOutlet var genreCollectionView: UICollectionView!
    @IBOutlet var movieCollectionView: UICollectionView!
    
    fileprivate var genreList: [GenreVO] = [
        .init(genreName: "ACTION", isSelected: true),
        .init(genreName: "ADVENTURE", isSelected: false),
        .init(genreName: "CRIMINAL", isSelected: false),
        .init(genreName: "DRAMMA", isSelected: false),
        .init(genreName: "COMEDY", isSelected: false),
        .init(genreName: "DOCUMENTARY", isSelected: false),
        .init(genreName: "BIOGRAPHY", isSelected: false)
    ]
    
    override func awakeFromNib() {
        super.awakeFromNib()
        
        genreCollectionView.delegate = self
        genreCollectionView.dataSource = self
        
        movieCollectionView.delegate = self
        movieCollectionView.dataSource = self
        
        genreCollectionView.registerWithNib(GenreCollectionViewCell.self)
        movieCollectionView.registerWithNib(MovieListCollectionViewCell.self)
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

    }
    
}

extension MovieWithGenreTableViewCell: UICollectionViewDataSource, UICollectionViewDelegateFlowLayout {
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return collectionView == genreCollectionView ? genreList.count : 10
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        
        if collectionView == genreCollectionView {
            return dequeueCollectionViewCell(ofType: GenreCollectionViewCell.self, with: collectionView, for: indexPath) { cell in
                // Pass data to the cell
                cell.data = genreList[indexPath.row]
                
                // Implement on tap event
                cell.onGenreTap = { [self] genreName in
                    resetGenreSelected(genreName)
                    genreCollectionView.reloadData()
                }
            }
        } else {
            return dequeueCollectionViewCell(ofType: MovieListCollectionViewCell.self, with: collectionView, for: indexPath)
        }
        
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        
        if collectionView == genreCollectionView {
            let textWidth = getWidthOf(text: genreList[indexPath.row].genreName, with: UIFont(name: "Geeze Pro Regular", size: 14) ?? UIFont.systemFont(ofSize: 14))
            return .init(width: textWidth + 20, height: 40)
        } else {
            return .init(width: collectionView.frame.width / 3, height: collectionView.frame.height)
        }
        
    }
    
    fileprivate func resetGenreSelected(_ genreName: String) {
        genreList.forEach { genre in
            if genre.genreName == genreName {
                genre.isSelected = true
            } else {
                genre.isSelected = false
            }
        }
    }
    
    fileprivate func getWidthOf(text: String, with font: UIFont) -> CGFloat {
        let attribute = [NSAttributedString.Key.font: font]
        let size = text.size(withAttributes: attribute)
        return size.width
    }
    
}
