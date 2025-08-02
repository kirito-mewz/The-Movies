//
//  String+Extensions.swift
//  The Movies
//
//  Created by Paing Htet on 02/08/2025.
//

import UIKit

extension String {
    func getWidth(of font: UIFont) -> CGFloat {
        let attribute = [NSAttributedString.Key.font : font]
        let size = self.size(withAttributes: attribute)
        return size.width
    }
}
