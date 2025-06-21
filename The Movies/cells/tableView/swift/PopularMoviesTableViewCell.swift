//
//  MovieListTableViewCell.swift
//  The Movies
//
//  Created by PaingHtet on 21/06/2025.
//

import UIKit

class PopularMoviesTableViewCell: UITableViewCell {
    
    @IBOutlet var popularMoviesCollectionView: UICollectionView!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        
        popularMoviesCollectionView.delegate = self
        popularMoviesCollectionView.dataSource = self
        
        popularMoviesCollectionView.registerWithNib(MovieListCollectionViewCell.self)
        
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

    }
    
}

extension PopularMoviesTableViewCell: UICollectionViewDataSource, UICollectionViewDelegateFlowLayout {
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return 6
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        return dequeueCollectionViewCell(ofType: MovieListCollectionViewCell.self, with: collectionView, for: indexPath)
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        return .init(width: collectionView.frame.width / 3, height: collectionView.frame.height)
    }
    
}
