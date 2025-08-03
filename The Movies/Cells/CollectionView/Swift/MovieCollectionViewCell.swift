//
//  MovieCollectionViewCell.swift
//  The Movies
//
//  Created by Paing Htet on 02/08/2025.
//

import UIKit
import SDWebImage

class MovieCollectionViewCell: UICollectionViewCell {
    
    var movie: Movie? {
        didSet {
            guard let data = movie else { return }
            if let imagePath = data.posterPath {
                movieImageView.sd_setImage(with: URL(string: "\(imageBaseURL)/\(imagePath)"))
            }
            movieTitleLabel.text = data.title ?? data.name
            ratingLabel.text = String(format: "%.1f", data.voteAverage ?? 0)
            ratingControl.rating = Int(round(data.voteAverage ?? 0) * 0.5)
        }
    }
    
    @IBOutlet var movieImageView: UIImageView!
    @IBOutlet var movieTitleLabel: UILabel!
    @IBOutlet var ratingLabel: UILabel!
    @IBOutlet var ratingControl: RatingControl!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

}
