//
//  ShowcaseCollectionViewCell.swift
//  The Movies
//
//  Created by Paing Htet on 02/08/2025.
//

import UIKit

class ShowcaseCollectionViewCell: UICollectionViewCell {
    
    @IBOutlet var placeholderView: UIView!
    @IBOutlet var movieImageView: UIImageView!
    @IBOutlet var playImageView: UIImageView!
    @IBOutlet var movieTitleLabel: UILabel!
    @IBOutlet var showDateLabel: UILabel!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        
        placeholderView.layer.cornerRadius = 8
        
    }

}
