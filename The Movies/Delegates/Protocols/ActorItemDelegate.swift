//
//  ActorItemDelegate.swift
//  The Movies
//
//  Created by Paing Htet on 02/08/2025.
//

import UIKit

protocol ActorItemDelegate {
    func onFavouriteTapped(isFavourite: Bool)
    func onActorCellTapped(actorId: Int?)
}

extension ActorItemDelegate where Self: UIViewController {
    func onActorCellTapped(actorId id: Int?) {
        let vc = ActorDetailViewController.instantiate()
        vc.actorId = id ?? -1
        (self as UIViewController).navigationController?.pushViewController(vc, animated: true)
    }
}
