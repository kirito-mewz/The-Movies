//
//  MovieSliderTableViewCell.swift
//  The Movies
//
//  Created by PaingHtet on 20/06/2025.
//

import UIKit

class MovieSliderTableViewCell: UITableViewCell {
    
    @IBOutlet var movieSliderCollectionView: UICollectionView!
    @IBOutlet var pageControl: UIPageControl!
    
    var delegate: MovieItemDelegate?

    override func awakeFromNib() {
        super.awakeFromNib()
        
        movieSliderCollectionView.delegate = self
        movieSliderCollectionView.dataSource = self
        
        movieSliderCollectionView.registerWithNib(MovieSliderCollectionViewCell.self)
        
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

    }
    
}

extension MovieSliderTableViewCell: UICollectionViewDataSource, UICollectionViewDelegateFlowLayout {
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return 3
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        return dequeueCollectionViewCell(ofType: MovieSliderCollectionViewCell.self, with: collectionView, for: indexPath)
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        return .init(width: collectionView.frame.width, height: collectionView.frame.height)
    }
    
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        delegate?.onItemTap()
    }
    
    func scrollViewDidEndScrollingAnimation(_ scrollView: UIScrollView) {
        pageControl.currentPage = Int(scrollView.contentOffset.x / contentView.frame.width)
    }
    
    func scrollViewDidEndDecelerating(_ scrollView: UIScrollView) {
        pageControl.currentPage = Int(scrollView.contentOffset.x / contentView.frame.width)
    }
    
}
