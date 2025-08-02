//
//  RatingControl.swift
//  The Movies
//
//  Created by Paing Htet on 01/08/2025.
//

import UIKit

@IBDesignable
class RatingControl: UIStackView {
    
    @IBInspectable
    var starCount: Int = 3 {
        didSet {
            setupButtons()
            setupRating()
        }
    }
    
    @IBInspectable
    var starSize: CGSize = .init(width: 150, height: 150) {
        didSet {
            setupButtons()
            setupRating()
        }
    }
    
    @IBInspectable
    var rating: Int = 3 {
        didSet {
            setupRating()
        }
    }
    
    var ratingButtons: [UIButton] = []
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        
        setupButtons()
        setupRating()
        
    }
    
    required init(coder: NSCoder) {
        super.init(coder: coder)
        
        setupButtons()
        setupRating()
        
    }
    
    fileprivate func setupButtons() {
        
        clearExistingButton()
        
        for _ in 0..<starCount {
            let button = UIButton(frame: .zero)
            button.setImage(#imageLiteral(resourceName: "ic_star_empty"), for: .normal)
            button.setImage(#imageLiteral(resourceName: "ic_star_filled"), for: .selected)
            button.translatesAutoresizingMaskIntoConstraints = false
            button.isUserInteractionEnabled = false
            
            NSLayoutConstraint.activate([
                button.widthAnchor.constraint(equalToConstant: starSize.width),
                button.heightAnchor.constraint(equalToConstant: starSize.height)
            ])
            
            
            addArrangedSubview(button)
            ratingButtons.append(button)
        }
    }
    
    
    fileprivate func setupRating() {
        for (index, button) in ratingButtons.enumerated() {
            button.isSelected = index < rating
        }
    }
    
    fileprivate func clearExistingButton() {
        ratingButtons.forEach { removeArrangedSubview($0); $0.removeFromSuperview() }
        ratingButtons.removeAll()
    }
    
}
