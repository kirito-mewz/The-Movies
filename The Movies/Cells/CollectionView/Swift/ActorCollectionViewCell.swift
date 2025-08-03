//
//  ActorCollectionViewCell.swift
//  The Movies
//
//  Created by Paing Htet on 02/08/2025.
//

import UIKit
import SDWebImage

class ActorCollectionViewCell: UICollectionViewCell {
    
    var actor: Actor? {
        didSet {
            guard let data = actor else { return }
            if let imagePath = data.profilePath {
                actorImageView.sd_setImage(with: URL(string: "\(imageBaseURL)/\(imagePath)"))
            }
            actorNameLabel.text = data.name
            roleLabel.text = data.role
        }
    }
    
    @IBOutlet var actorImageView: UIImageView!
    @IBOutlet var heartFilledImageView: UIImageView!
    @IBOutlet var heartImageView: UIImageView!
    @IBOutlet var actorNameLabel: UILabel!
    @IBOutlet var roleLabel: UILabel!
    
    var delegate: ActorItemDelegate?

    override func awakeFromNib() {
        super.awakeFromNib()
        
        initializeGestureRecognizer()
        
    }
    
    fileprivate func initializeGestureRecognizer() {
        heartImageView.addGestureRecognizer(UITapGestureRecognizer(target: self, action: #selector(onTapFavourite)))
        heartFilledImageView.addGestureRecognizer(UITapGestureRecognizer(target: self, action: #selector(onTapUnFavourite)))
    }
    
    @IBAction fileprivate func onTapFavourite() {
        heartImageView.isHidden = true
        heartFilledImageView.isHidden = false
        delegate?.onFavouriteTapped(isFavourite: true)
    }
    
    @IBAction fileprivate func onTapUnFavourite() {
        heartImageView.isHidden = false
        heartFilledImageView.isHidden = true
        delegate?.onFavouriteTapped(isFavourite: false)
    }

}
