//
//  ShowcaseCollectionViewCell.swift
//  The Movies
//
//  Created by PaingHtet on 21/06/2025.
//

import UIKit

class ShowcaseCollectionViewCell: UICollectionViewCell {
    
    @IBOutlet var containerView: UIView!
    @IBOutlet var movieImageView: UIImageView!
    @IBOutlet var playImageView: UIImageView!
    @IBOutlet var movieTitleLabel: UILabel!
    @IBOutlet var showDateLabel: UILabel!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        
        containerView.layer.cornerRadius = 4
        containerView.clipsToBounds = true
    }

}
