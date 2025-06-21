//
//  PersonTableViewCell.swift
//  The Movies
//
//  Created by PaingHtet on 21/06/2025.
//

import UIKit

class PersonTableViewCell: UITableViewCell {
    
    @IBOutlet var moreActorsLabel: UILabel!
    @IBOutlet var personCollectionView: UICollectionView!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        
        moreActorsLabel.underline(for: "MORE ACTORS")
        
        personCollectionView.delegate = self
        personCollectionView.dataSource = self
        
        personCollectionView.registerWithNib(PersonCollectionViewCell.self)
        
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

    }
    
}

extension PersonTableViewCell: UICollectionViewDataSource, UICollectionViewDelegateFlowLayout {
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return 10
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = dequeueCollectionViewCell(ofType: PersonCollectionViewCell.self, with: collectionView, for: indexPath)
        cell.personActionDelegate = self
        return cell
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        return .init(width: collectionView.frame.width / 2.5, height: collectionView.frame.height)
    }
    
}

extension PersonTableViewCell: PersonActionDelegate {
    func onFavouriteTap(isFavourite: Bool) {
        debugPrint("isFavourite: \(isFavourite)")
    }
}
