//
//  ShowcaseTableViewCell.swift
//  The Movies
//
//  Created by Paing Htet on 02/08/2025.
//

import UIKit

class ShowcaseTableViewCell: UITableViewCell {
    
    @IBOutlet var moreShowcasesLabel: UILabel!
    @IBOutlet var showcaseCollectionView: UICollectionView!
    @IBOutlet var collectionViewHeight: NSLayoutConstraint!
    
    var onMoreShowcasesTapped: (() -> Void)?
    
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
        return 10
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        return collectionView.dequeueCell(ofType: ShowcaseCollectionViewCell.self, for: indexPath, shouldRegister: true)
    }
    
    // UICollectionViewDelegateFlowLayout
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        return .init(width: collectionView.frame.width * 0.8, height: collectionView.frame.height - 40)
    }
    
}
