//
//  GenreCollectionViewCell.swift
//  The Movies
//
//  Created by Paing Htet on 02/08/2025.
//

import UIKit

class GenreCollectionViewCell: UICollectionViewCell {
    
    var data: GenreVO? {
        didSet {
            guard let genre = data else { return }
            genreLabel.text = genre.genreName
            overlayView.isHidden = !genre.isSelected
            genreLabel.textColor = genre.isSelected ? .white : .init(red: 63/255, green: 69/255, blue: 96/255, alpha: 1)
        }
    }
    
    @IBOutlet var placeholderView: UIView!
    @IBOutlet var genreLabel: UILabel!
    @IBOutlet var overlayView: UIView!
    
    var onGenreTap: ((Int) -> Void) = { _ in }
    
    override func awakeFromNib() {
        super.awakeFromNib()
        
        placeholderView.addGestureRecognizer(UITapGestureRecognizer(target: self, action: #selector(_didCellTap)))
        
    }
    
    
    @objc fileprivate func _didCellTap() {
        onGenreTap(data?.id ?? 0)
    }

}
