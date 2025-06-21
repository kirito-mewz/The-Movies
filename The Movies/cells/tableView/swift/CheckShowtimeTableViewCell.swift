//
//  CheckShowtimeTableViewCell.swift
//  The Movies
//
//  Created by PaingHtet on 21/06/2025.
//

import UIKit

class CheckShowtimeTableViewCell: UITableViewCell {
    
    @IBOutlet var checkMovieContainerView: UIView!
    @IBOutlet var seeMoreLabel: UILabel!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        
        checkMovieContainerView.layer.cornerRadius = 4
        seeMoreLabel.underline(for: "SEE MORE", color: UIColor.init(named: "Color_Yellow") ?? .white)
        
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

    }
    
}
