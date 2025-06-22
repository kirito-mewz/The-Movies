//
//  Storyboarded.swift
//  The Movies
//
//  Created by PaingHtet on 22/06/2025.
//

import UIKit

protocol Storyboarded {
    static func instantiate() -> Self
}

extension Storyboarded where Self: UIViewController {
    
    static func instantiate() -> Self {
        let storyborad = UIStoryboard(name: "Main", bundle: Bundle.main)
        return storyborad.instantiateViewController(identifier: String(describing: self)) as! Self
    }
    
}
