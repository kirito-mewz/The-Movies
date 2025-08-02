//
//  ActorDetailViewController.swift
//  The Movies
//
//  Created by Paing Htet on 01/08/2025.
//

import UIKit

class ActorDetailViewController: UIViewController, Storyboarded {

    // MARK: - IBOutlets
    @IBOutlet var profileImageView: UIImageView!
    @IBOutlet var nameLabel: UILabel!
    @IBOutlet var roleLabel: UILabel!
    @IBOutlet var popularityLabel: UILabel!
    @IBOutlet var biographyLabel: UILabel!
    @IBOutlet var detailNameLabel: UILabel!
    @IBOutlet var detailAkaLabel: UILabel!
    @IBOutlet var detailBirthdayLabel: UILabel!
    @IBOutlet var detailBirthPlace: UILabel!
    @IBOutlet var detailRoleLabel: UILabel!
    @IBOutlet var knownForCollectionView: UICollectionView!
    
    // MARK:  - Properties
    
    // MARK: - Lifecycles
    override func viewDidLoad() {
        super.viewDidLoad()
        
        knownForCollectionView.delegate = self
        knownForCollectionView.dataSource = self

    }

}

extension ActorDetailViewController: UICollectionViewDataSource, UICollectionViewDelegateFlowLayout {
    
    // UICollectionViewDataSource
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return 10
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        return collectionView.dequeueCell(ofType: MovieCollectionViewCell.self, for: indexPath, shouldRegister: true)
    }
    
    // UICollectionViewDelegateFlowLayout
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        return .init(width: collectionView.frame.width / 3, height: collectionView.frame.height)
    }
    
    // Delegate
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        self.onMovieCellTapped()
    }
    
}

// MARK: - Custom Delegate
extension ActorDetailViewController: MovieItemDelegate, ActorItemDelegate {
    func onFavouriteTapped(isFavourite: Bool) {
        // Todo
    }
}
