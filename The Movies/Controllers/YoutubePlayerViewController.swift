//
//  YoutubePlayerViewController.swift
//  The Movies
//
//  Created by Paing Htet on 01/08/2025.
//

import UIKit

class YoutubePlayerViewController: UIViewController, Storyboarded {
    
    // MARK: - IBOutlets
    @IBOutlet var youtubePlayerView: UIView!
    @IBOutlet var heightConstraint: NSLayoutConstraint!
    
    // MARK:  - Properties
    
    // MARK: - Lifecycles
    override func viewDidLoad() {
        super.viewDidLoad()

    }
    
    override func viewDidLayoutSubviews() {
        super.viewDidLayoutSubviews()
        heightConstraint.constant = (self.view.frame.width * 9) / 16
    }

}
