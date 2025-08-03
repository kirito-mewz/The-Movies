//
//  ActorDetailViewController.swift
//  The Movies
//
//  Created by Paing Htet on 01/08/2025.
//

import UIKit
import SDWebImage

class ActorDetailViewController: UIViewController, Storyboarded {
    
    var detail: ActorDetailResponse? {
        didSet {
            guard let data = detail else { return }
            bindData(with: data)
        }
    }

    // MARK: - IBOutlets
    @IBOutlet var profileImageView: UIImageView!
    @IBOutlet var imageHeightConstraint: NSLayoutConstraint!
    @IBOutlet var nameLabel: UILabel!
    @IBOutlet var roleLabel: UILabel!
    @IBOutlet var popularityLabel: UILabel!
    @IBOutlet var biographyLabel: UILabel!
    @IBOutlet var detailNameLabel: UILabel!
    @IBOutlet var detailAkaLabel: UILabel!
    @IBOutlet var detailBirthdayLabel: UILabel!
    @IBOutlet var detailBirthPlaceLabel: UILabel!
    @IBOutlet var detailRoleLabel: UILabel!
    @IBOutlet var knownForCollectionView: UICollectionView!
    
    // MARK:  - Properties
    var actorId: Int = -1
    var movies: [Movie] = []
    
    let actorModel: ActorModel = ActorModelImpl.shared
    
    // MARK: - Lifecycles
    override func viewDidLoad() {
        super.viewDidLoad()
        
        knownForCollectionView.delegate = self
        knownForCollectionView.dataSource = self
        
        loadData()
        
    }
    
    override func viewDidLayoutSubviews() {
        let height = self.view.frame.width + self.view.frame.width * 0.5
        imageHeightConstraint.constant = height
        
        if profileImageView.layer.sublayers == nil {
            setupGradientLayer(height)
        }
    }
    
    private func setupGradientLayer(_ imageViewHeight: CGFloat) {
        let gradientLayer = CAGradientLayer()
        gradientLayer.colors = [UIColor.clear.cgColor, UIColor.init(named: "Color_Primary")!.cgColor]
        gradientLayer.locations = [0, 0.9]
        profileImageView.layer.addSublayer(gradientLayer)
        
        let gradientHeight = imageViewHeight * 0.5
        gradientLayer.frame = CGRect(x: 0, y: imageViewHeight - gradientHeight, width: self.view.frame.width, height: gradientHeight)
    }
    
    // MARK: - Private Helpers
    private func bindData(with detail: ActorDetailResponse) {
        
        if let imagePath = detail.profilePath {
            profileImageView.sd_setImage(with: URL(string: "\(imageBaseURL)/\(imagePath)"))
        }
        nameLabel.text = detail.name
        roleLabel.text = (detail.gender ?? 1) == 0 ? "Actor" : "Actress"
        popularityLabel.text = String(format: "%.2f", detail.popularity ?? 0)
        biographyLabel.text = detail.biography
        
        detailNameLabel.text = detail.name
        
        var rawAkaNames = detail.alsoKnownAs?.map { $0 }.reduce("") { "\($0 ?? "") \($1), " } ?? ""
        if (rawAkaNames.count) >= 2 {
            rawAkaNames.removeLast(2)
        }
        detailAkaLabel.text = rawAkaNames
        
        detailBirthdayLabel.text = detail.birthday
        detailBirthPlaceLabel.text = detail.placeOfBirth
        detailRoleLabel.text = (detail.gender ?? 1) == 0 ? "Actor" : "Actress"
        
    }

}

