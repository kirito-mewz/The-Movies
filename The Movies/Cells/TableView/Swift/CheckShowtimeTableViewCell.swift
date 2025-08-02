//
//  CheckShowtimeTableViewCell.swift
//  The Movies
//
//  Created by Paing Htet on 02/08/2025.
//

import UIKit

class CheckShowtimeTableViewCell: UITableViewCell {

    @IBOutlet var seeMoreLabel: UILabel!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        
        seeMoreLabel.underline(for: "SEE MORE", color: UIColor(named: "Color_Yellow") ?? .white)
        
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }
    
}
