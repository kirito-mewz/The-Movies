//
//  ActorTableViewCell.swift
//  The Movies
//
//  Created by Paing Htet on 02/08/2025.
//

import UIKit

class ActorTableViewCell: UITableViewCell {
    
    @IBOutlet var moreActorsLabel: UILabel!
    @IBOutlet var actorCollectionView: UICollectionView!
    
    var delegate: ActorItemDelegate?
    
    var onMoreActorsTapped: (() -> Void)?
    
    override func awakeFromNib() {
        super.awakeFromNib()
        
        moreActorsLabel.underline(for: "MORE ACTORS")
        moreActorsLabel.addGestureRecognizer(UITapGestureRecognizer(target: self, action: #selector(handleMoreActorsTapped(_:))))
        
        actorCollectionView.delegate = self
        actorCollectionView.dataSource = self
        
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }
    
    @IBAction private func handleMoreActorsTapped(_ sender: Any?) {
        onMoreActorsTapped?()
    }
    
}

extension ActorTableViewCell: UICollectionViewDataSource, UICollectionViewDelegateFlowLayout {
    
    // UICollectionViewDataSource
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return 10
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueCell(ofType: ActorCollectionViewCell.self, for: indexPath, shouldRegister: true)
        cell.delegate = self.delegate
        return cell
    }

    
    // UICollectionViewDelegateFlowLayout
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        return .init(width: collectionView.frame.width / 2.5, height: collectionView.frame.height)
    }
    
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        delegate?.onActorCellTapped()
    }
}
