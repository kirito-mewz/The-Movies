//
//  Storyboarded.swift
//  The Movies
//
//  Created by Paing Htet on 02/08/2025.
//

import UIKit

protocol Storyboarded {
    static func instantiate() -> Self
}

extension Storyboarded where Self: UIViewController {
    static func instantiate() -> Self {
        let storyboard = UIStoryboard.init(name: "Main", bundle: Bundle.main)
        return storyboard.instantiateViewController(identifier: String(describing: self)) as! Self
    }
}
