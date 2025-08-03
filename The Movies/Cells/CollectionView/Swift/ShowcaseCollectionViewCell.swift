//
//  ShowcaseCollectionViewCell.swift
//  The Movies
//
//  Created by Paing Htet on 02/08/2025.
//

import UIKit
import SDWebImage

class ShowcaseCollectionViewCell: UICollectionViewCell {
    
    var movie: Movie? {
        didSet {
            guard let data = movie else { return }
            if let imagePath = data.backdropPath {
                movieImageView.sd_setImage(with: URL(string: "\(imageBaseURL)/\(imagePath)"))
            }
            movieTitleLabel.text = data.title
            showDateLabel.text = data.releaseDate
        }
    }
    
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
