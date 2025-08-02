//
//  UILabel+Extensions.swift
//  The Movies
//
//  Created by Paing Htet on 02/08/2025.
//

import UIKit

extension UILabel {
    /// Underline the given string.
    /// - Parameters:
    ///   - text: Any text to be underlined
    ///   - color: The underline color. Default is white
    func underline(for text: String, color: UIColor = .white) {
        let attributedString = NSMutableAttributedString(string: text)
        attributedString.addAttributes([NSAttributedString.Key.underlineStyle: 2, NSAttributedString.Key.underlineColor: color], range: NSRange(location: 0, length: text.count))
        attributedText = attributedString
    }
}
