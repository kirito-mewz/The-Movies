//
//  UICollectionView+Extensions.swift
//  The Movies
//
//  Created by PaingHtet on 20/06/2025.
//

import UIKit

extension UICollectionView {
    
    func registerWithNib<T: UICollectionViewCell>(_ cellType: T.Type) {
        register(UINib(nibName: String(describing: T.self), bundle: nil), forCellWithReuseIdentifier: String(describing: T.self))
    }
    
}
