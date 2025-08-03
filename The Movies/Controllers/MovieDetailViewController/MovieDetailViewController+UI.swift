//
//  MovieDetailViewController+UI.swift
//  The Movies
//
//  Created by Paing Htet on 04/08/2025.
//

import UIKit

extension MovieDetailViewController {
    
    func setupGradientLayer() {
        let gradientLayer = CAGradientLayer()
        gradientLayer.colors = [UIColor.clear.cgColor, UIColor(named: "Color_Dark_Blue")!.cgColor]
        gradientLayer.locations = [0, 0.8]
        movieImageView.layer.addSublayer(gradientLayer)
        
        let gradientHeight = movieImageView.frame.height * 0.5
        gradientLayer.frame = CGRect(x: 0, y: movieImageView.frame.height - gradientHeight, width: movieImageView.frame.width, height: gradientHeight)
    }
    
    func configureButton() {
        playTrailerButton.layer.cornerRadius = playTrailerButton.frame.height / 2
        
        rateMovieButton.layer.cornerRadius = rateMovieButton.frame.height / 2
        rateMovieButton.layer.borderColor = UIColor.white.cgColor
        rateMovieButton.layer.borderWidth = 1
    }
    
}
