//
//  MovieListCollectionViewCell.swift
//  The Movies
//
//  Created by PaingHtet on 21/06/2025.
//

import UIKit

class MovieListCollectionViewCell: UICollectionViewCell {

    @IBOutlet var movieImageView: UIImageView!
    @IBOutlet var movieTitleLabel: UILabel!
    @IBOutlet var ratingLabel: UILabel!
    @IBOutlet var ratingControl: RatingControl!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        
    }

}
