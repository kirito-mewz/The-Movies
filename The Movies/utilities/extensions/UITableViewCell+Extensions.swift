//
//  UITableView+Extensions.swift
//  The Movies
//
//  Created by PaingHtet on 20/06/2025.
//

import UIKit

extension UITableViewCell {
    
    func dequeueCollectionViewCell<T: UICollectionViewCell>(ofType: T.Type, with collectionView: UICollectionView, for indexPath: IndexPath, _ setupCell: ((T) -> Void) = {_ in}) -> T {
        
        guard let cell = collectionView.dequeueReusableCell(withReuseIdentifier: String(describing: T.self), for: indexPath) as? T else {
            fatalError("ERROR: Fail to cast the given cell into \(T.self)")
        }
        setupCell(cell)
        return cell
        
    }
    
}

extension UIViewController {
    
    func dequeueCollectionViewCell<T: UICollectionViewCell>(ofType: T.Type, with collectionView: UICollectionView, for indexPath: IndexPath, _ setupCell: ((T) -> Void) = {_ in}) -> T {
        
        guard let cell = collectionView.dequeueReusableCell(withReuseIdentifier: String(describing: T.self), for: indexPath) as? T else {
            fatalError("ERROR: Fail to cast the given cell into \(T.self)")
        }
        setupCell(cell)
        return cell
        
    }
    
}
