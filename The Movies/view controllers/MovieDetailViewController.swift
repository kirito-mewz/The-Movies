//
//  MovieDetailViewController.swift
//  The Movies
//
//  Created by PaingHtet on 21/06/2025.
//

import UIKit

class MovieDetailViewController: UIViewController {
    
    
    @IBOutlet var backwardButton: UIButton!
    @IBOutlet var searchButton: UIImageView!
    @IBOutlet var movieImageView: UIImageView!
    
    @IBOutlet var movieYearLabel: UILabel!
    @IBOutlet var ratingControl: RatingControl!
    @IBOutlet var votesCountLabel: UILabel!
    @IBOutlet var ratingVotesLabel: UILabel!
    @IBOutlet var movieTitleLabel: UILabel!
    @IBOutlet var durationTimeLabel: UILabel!
    @IBOutlet var heartImageView: UIImageView!
    
    @IBOutlet var storylineDescription: UILabel!
    @IBOutlet var playTrailerButton: UIButton!
    @IBOutlet var rateMovieButton: UIButton!
    
    @IBOutlet var actorsCollectionView: UICollectionView!
    
    @IBOutlet var originalTitleLabel: UILabel!
    @IBOutlet var typeLabel: UILabel!
    @IBOutlet var producationLabel: UILabel!
    @IBOutlet var premiereLabel: UILabel!
    @IBOutlet var descriptionLabel: UILabel!
    
    @IBOutlet var moreCreatorsLabel: UILabel!
    @IBOutlet var creatorsCollectionView: UICollectionView!
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        playTrailerButton.layer.cornerRadius = playTrailerButton.frame.height / 2
        
        rateMovieButton.layer.borderColor = UIColor.white.cgColor
        rateMovieButton.layer.borderWidth = 1
        rateMovieButton.layer.cornerRadius = rateMovieButton.frame.height / 2
        
        moreCreatorsLabel.underline(for: moreCreatorsLabel.text ?? "")
        
        [actorsCollectionView, creatorsCollectionView].forEach {
            $0?.delegate = self
            $0?.dataSource = self
            $0?.registerWithNib(PersonCollectionViewCell.self)
        }

    }

}

extension MovieDetailViewController: UICollectionViewDataSource, UICollectionViewDelegateFlowLayout {
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return 10
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = dequeueCollectionViewCell(ofType: PersonCollectionViewCell.self, with: collectionView, for: indexPath)
        cell.personActionDelegate = self
        return cell
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        return .init(width: collectionView.frame.width / 2.5, height: collectionView.frame.height)
    }
    
}

extension MovieDetailViewController: PersonActionDelegate {
    func onFavouriteTap(isFavourite: Bool) {
        // Do Something
    }
}
