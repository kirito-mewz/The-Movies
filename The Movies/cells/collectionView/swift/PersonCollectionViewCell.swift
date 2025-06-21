//
//  PersonCollectionViewCell.swift
//  The Movies
//
//  Created by PaingHtet on 21/06/2025.
//

import UIKit

class PersonCollectionViewCell: UICollectionViewCell {
    
    @IBOutlet var personImageView: UIImageView!
    @IBOutlet var heartFilledImageView: UIImageView!
    @IBOutlet var heartImageView: UIImageView!
    
    @IBOutlet var personNameLabel: UILabel!
    @IBOutlet var thumbUpImageView: UIImageView!
    @IBOutlet var likeMovieLabel: UILabel!
    
    var personActionDelegate: PersonActionDelegate?
    
    override func awakeFromNib() {
        super.awakeFromNib()
        
        initializeGestureRecongnizer()
        
    }
    
    fileprivate func initializeGestureRecongnizer() {
        heartImageView.addGestureRecognizer(UITapGestureRecognizer(target: self, action: #selector(onTapFavourite)))
        heartFilledImageView.addGestureRecognizer(UITapGestureRecognizer(target: self, action: #selector(onTapUnFavourtie)))
        
        [heartImageView, heartFilledImageView].forEach { $0?.isUserInteractionEnabled = true }
    }
    
    @objc fileprivate func onTapFavourite() {
        heartImageView.isHidden = true
        heartFilledImageView.isHidden = false
        personActionDelegate?.onFavouriteTap(isFavourite: true)
    }
    
    @objc fileprivate func onTapUnFavourtie() {
        heartImageView.isHidden = false
        heartFilledImageView.isHidden = true
        personActionDelegate?.onFavouriteTap(isFavourite: false)
    }

}
