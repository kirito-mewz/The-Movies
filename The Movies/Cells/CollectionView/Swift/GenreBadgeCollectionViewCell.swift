//
//  GenreBadgeCollectionViewCell.swift
//  The Movies
//
//  Created by Paing Htet on 02/08/2025.
//

import UIKit

class GenreBadgeCollectionViewCell: UICollectionViewCell {
    
    @IBOutlet var placeholderView: UIView!
    @IBOutlet var genreLabel: UILabel!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        
        placeholderView.layer.cornerRadius = 12
        
    }

}
