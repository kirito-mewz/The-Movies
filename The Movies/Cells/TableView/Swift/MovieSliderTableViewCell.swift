//
//  MovieSliderTableViewCell.swift
//  The Movies
//
//  Created by Paing Htet on 02/08/2025.
//

import UIKit

class MovieSliderTableViewCell: UITableViewCell {
    
    var movies: [Movie]? {
        didSet {
            movieSliderCollectionView.reloadData()
            pageControl.numberOfPages = movies?.count ?? 0
        }
    }
    
    @IBOutlet var movieSliderCollectionView: UICollectionView!
    @IBOutlet var pageControl: UIPageControl!
    
    var delegate: MovieItemDelegate?
    
    override func awakeFromNib() {
        super.awakeFromNib()
        
        movieSliderCollectionView.delegate = self
        movieSliderCollectionView.dataSource = self
        
        pageControl.addTarget(self, action: #selector(pageControlTapped(_:)), for: .valueChanged)
        
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }
    
    @objc func pageControlTapped(_ sender: UIPageControl) {
        let indexPath = IndexPath(item: sender.currentPage, section: 0)
        movieSliderCollectionView.scrollToItem(at: indexPath, at: .centeredHorizontally, animated: true)
    }
    
}

extension MovieSliderTableViewCell: UICollectionViewDataSource, UICollectionViewDelegateFlowLayout {
    
    // UICollectionViewDataSource
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return movies?.count ?? 0
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueCell(ofType: MovieSliderCollectionViewCell.self, for: indexPath, shouldRegister: true)
        cell.movie = movies?[indexPath.row]
        return cell
    }
    
    // UICollectionViewDelegateFlowLayout
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        return .init(width: collectionView.frame.width, height: collectionView.frame.height)
    }
    
    // Scroll
    func scrollViewDidEndDecelerating(_ scrollView: UIScrollView) {
        pageControl.currentPage = Int(scrollView.contentOffset.x / scrollView.frame.width)
    }
    
    func scrollViewDidEndScrollingAnimation(_ scrollView: UIScrollView) {
        pageControl.currentPage = Int(scrollView.contentOffset.x / scrollView.frame.width)
    }
    
    func scrollViewDidScroll(_ scrollView: UIScrollView) {
        pageControl.currentPage = Int(scrollView.contentOffset.x / scrollView.frame.width)
    }
    
    // Delegate
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        delegate?.onMovieCellTapped(movieId: movies?[indexPath.row].id ?? 0, type: .movie)
    }
 
}
