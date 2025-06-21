//
//  GenreCollectionViewCell.swift
//  The Movies
//
//  Created by PaingHtet on 21/06/2025.
//

import UIKit

class GenreCollectionViewCell: UICollectionViewCell {
    
    @IBOutlet var containerView: UIView!
    @IBOutlet var genreLabel: UILabel!
    @IBOutlet var overlayView: UIView!
    
    var onGenreTap: ((String) -> Void) = {_ in}
    
    var data: GenreVO? = nil {
        didSet {
            if let data = data {
                genreLabel.text = data.genreName
                overlayView.isHidden = !data.isSelected
                genreLabel.textColor = data.isSelected ? .white : .init(red: 63/255, green: 69/255, blue: 96/255, alpha: 1)
            }
        }
    }
    
    override func awakeFromNib() {
        super.awakeFromNib()
        
        containerView.addGestureRecognizer(UITapGestureRecognizer(target: self, action: #selector(_didCallTap)))
    }
    
    @objc fileprivate func _didCallTap() {
        onGenreTap(data?.genreName ?? "")
    }

}
