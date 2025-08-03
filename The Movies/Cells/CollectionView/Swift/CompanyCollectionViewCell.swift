//
//  CompanyCollectionViewCell.swift
//  The Movies
//
//  Created by Paing Htet on 02/08/2025.
//

import UIKit
import SDWebImage

class CompanyCollectionViewCell: UICollectionViewCell {
    
    var company: ProductionCompany? {
        didSet {
            guard let data = company else { return }
            if let logoPath = data.logoPath {
                companyImageView.sd_setImage(with: URL(string: "\(imageBaseURL)/\(logoPath)"))
                companyNameLabel.text = ""
            } else {
                companyNameLabel.text = data.name
            }
        }
    }
    
    @IBOutlet var companyImageView: UIImageView!
    @IBOutlet var companyNameLabel: UILabel!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

}
