//
//  MovieSliderCollectionViewCell.swift
//  The Movies
//
//  Created by Paing Htet on 02/08/2025.
//

import UIKit
import SDWebImage

class MovieSliderCollectionViewCell: UICollectionViewCell {
    
    var movie: Movie? {
        didSet {
            guard let data = movie else { return }
            if let imagePath = data.backdropPath {
                movieImageView.sd_setImage(with: URL(string: "\(imageBaseURL)/\(imagePath)"))
            }
            movieTitleLabel.text = data.title
        }
    }
    
    @IBOutlet var movieImageView: UIImageView!
    @IBOutlet var playImageView: UIImageView!
    @IBOutlet var movieTitleLabel: UILabel!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        
        setupGradientLayer()
        
    }
    
    private func setupGradientLayer() {
        let gradientLayer = CAGradientLayer()
        gradientLayer.colors = [UIColor.clear.cgColor, UIColor(named: "Color_Primary")!.cgColor]
        gradientLayer.locations = [0, 0.7]
        movieImageView.layer.addSublayer(gradientLayer)
        
        let gradientHeight = movieImageView.frame.height * 0.5
        gradientLayer.frame = CGRect(x: 0, y: movieImageView.frame.height - gradientHeight, width: movieImageView.frame.width, height: gradientHeight)
    }

}
