//
//  ShowcaseTableViewCell.swift
//  The Movies
//
//  Created by PaingHtet on 21/06/2025.
//

import UIKit

class ShowcaseTableViewCell: UITableViewCell {
    
    @IBOutlet var moreShowcaseLabel: UILabel!
    @IBOutlet var showcaseCollectionView: UICollectionView!
    
    var delegate: MovieItemDelegate?
    
    override func awakeFromNib() {
        super.awakeFromNib()
        
        moreShowcaseLabel.underline(for: "MORE SHOWCASES")
        
        showcaseCollectionView.delegate = self
        showcaseCollectionView.dataSource = self
        
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

    }
    
}

extension ShowcaseTableViewCell: UICollectionViewDataSource, UICollectionViewDelegateFlowLayout {
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return 5
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        return collectionView.dequeueCell(ofType: ShowcaseCollectionViewCell.self, for: indexPath, shouldRegister: true)
    }
    
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        delegate?.onItemTap()
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        return .init(width: collectionView.frame.width * 0.8, height: collectionView.frame.height - 46)
    }
    
    func scrollViewDidScroll(_ scrollView: UIScrollView) {
        // Getting horizontal indicator which is index 0, form scroll view
        let horizontalScrollView = scrollView.subviews[(scrollView.subviews.count - 1)].subviews[0]
        horizontalScrollView.backgroundColor = UIColor(named: "Color_Yellow")
    }
    
}
