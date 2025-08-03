//
//  YoutubePlayerViewController.swift
//  The Movies
//
//  Created by Paing Htet on 01/08/2025.
//

import UIKit
import YoutubePlayerView

class YoutubePlayerViewController: UIViewController, Storyboarded {
    
    // MARK: - IBOutlets
    @IBOutlet var youtubePlayerView: YoutubePlayerView!
    @IBOutlet var heightConstraint: NSLayoutConstraint!
    
    // MARK:  - Properties
    var keyPath: String?
    
    // MARK: - Lifecycles
    override func viewDidLoad() {
        super.viewDidLoad()
        
        guard let keyPath = keyPath else { return }
        
        youtubePlayerView.loadWithVideoId(keyPath)
        youtubePlayerView.play()
    }
    
    override func viewDidLayoutSubviews() {
        super.viewDidLayoutSubviews()
        heightConstraint.constant = (self.view.frame.width * 9) / 16
    }

}
