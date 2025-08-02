//
//  UICollectionView+Extensions.swift
//  The Movies
//
//  Created by Paing Htet on 02/08/2025.
//

import UIKit

extension UICollectionView {
    
    /// Register the cell in this collection view
    /// - Parameter cell: The cell to register
    func registerWithNib<T: UICollectionViewCell>(_ cellType: T.Type) {
        register(UINib(nibName: String(describing: T.self), bundle: nil), forCellWithReuseIdentifier: String(describing: T.self))
    }
    
    /// Dequeue the given cell for this collection view
    /// - Parameters:
    ///   - type: UICollectionViewCell itself or any child to be dequeued
    ///   - indexPath: Cell's indexpath in the collection view
    ///   - shouldRegister: Register the cell to this collection view before creation. Default: false
    ///   - setupCell: Additional cell configuration or data set up
    /// - Returns: The fully-configured cell
    func dequeueCell<T: UICollectionViewCell>(
        ofType type: T.Type,
        for indexPath: IndexPath,
        shouldRegister: Bool = false,
        _ setupCell: ((T) -> Void) = {_ in}
    ) -> T {
        
        if shouldRegister {
            self.registerWithNib(type)
        }
        guard let cell = self.dequeueReusableCell(withReuseIdentifier: String(describing: type), for: indexPath) as? T else {
            fatalError("ERROR: Fail to dequeue the given cell into: \(T.self)")
        }
        setupCell(cell)
        return cell
        
    }
    
}
