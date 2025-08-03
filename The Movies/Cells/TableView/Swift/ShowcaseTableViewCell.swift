//
//  ShowcaseTableViewCell.swift
//  The Movies
//
//  Created by Paing Htet on 02/08/2025.
//

import UIKit

class ShowcaseTableViewCell: UITableViewCell {
    
    var movies: [Movie]? {
        didSet {
            showcaseCollectionView.reloadData()
        }
    }
    
    @IBOutlet var moreShowcasesLabel: UILabel!
    @IBOutlet var showcaseCollectionView: UICollectionView!
    @IBOutlet var collectionViewHeight: NSLayoutConstraint!
    
    var onMoreShowcasesTapped: (() -> Void)?
    
    var delegate: MovieItemDelegate?
    
    override func awakeFromNib() {
        super.awakeFromNib()
        
        moreShowcasesLabel.underline(for: "MORE SHOWCASES")
        moreShowcasesLabel.addGestureRecognizer(UITapGestureRecognizer(target: self, action: #selector(handleMoreShowcasesTapped(_:))))
        
        showcaseCollectionView.delegate = self
        showcaseCollectionView.dataSource = self
        
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }
    
    @IBAction private func handleMoreShowcasesTapped(_ sender: Any) {
        onMoreShowcasesTapped?()
    }
    
}

extension ShowcaseTableViewCell: UICollectionViewDataSource, UICollectionViewDelegateFlowLayout {
    
    // UICollectionViewDataSource
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return movies?.count ?? 0
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueCell(ofType: ShowcaseCollectionViewCell.self, for: indexPath, shouldRegister: true)
        cell.movie = movies?[indexPath.row]
        return cell
    }
    
    // UICollectionViewDelegateFlowLayout
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        return .init(width: collectionView.frame.width * 0.8, height: collectionView.frame.height - 40)
    }
    
    // Horizontal Scroll
    func scrollViewDidScroll(_ scrollView: UIScrollView) {
        let horizontalScrollView = scrollView.subviews[(scrollView.subviews.count - 1)].subviews[0]
        horizontalScrollView.backgroundColor = UIColor(named: "Color_Yellow")
    }
    
    // Delegate
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        delegate?.onMovieCellTapped(movieId: movies?[indexPath.row].id ?? 0, type: .movie)
    }
    
}
