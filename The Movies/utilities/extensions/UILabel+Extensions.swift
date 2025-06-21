//
//  UILabel+Extensions.swift
//  The Movies
//
//  Created by PaingHtet on 21/06/2025.
//

import UIKit

extension UILabel {
    
    func underline(for text: String, color: UIColor = .white) {
        let attributedString = NSMutableAttributedString(string: text)
        attributedString.addAttributes([NSAttributedString.Key.underlineStyle: 2, NSAttributedString.Key.underlineColor: color], range: NSRange(location: 0, length: text.count))
        attributedText = attributedString
    }
    
}
