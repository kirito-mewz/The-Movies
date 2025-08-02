//
//  ActorItemDelegate.swift
//  The Movies
//
//  Created by Paing Htet on 02/08/2025.
//

import UIKit

protocol ActorItemDelegate {
    func onFavouriteTapped(isFavourite: Bool)
    func onActorCellTapped()
}

extension ActorItemDelegate where Self: UIViewController {
    func onActorCellTapped() {
        let vc = ActorDetailViewController.instantiate()
        (self as UIViewController).navigationController?.pushViewController(vc, animated: true)
    }
}
