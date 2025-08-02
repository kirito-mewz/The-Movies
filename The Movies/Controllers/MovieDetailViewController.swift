//
//  MovieDetailViewController.swift
//  The Movies
//
//  Created by Paing Htet on 01/08/2025.
//

import UIKit

class MovieDetailViewController: UIViewController, Storyboarded {
    
    fileprivate var genreList: [GenreVO] = [
        .init(id: 1, genreName: "ACTION", isSelected: true),
        .init(id: 2, genreName: "ADVENTURE", isSelected: false),
        .init(id: 3, genreName: "CRIMINAL", isSelected: false),
        .init(id: 4, genreName: "DRAMMA", isSelected: false),
        .init(id: 5, genreName: "COMEDY", isSelected: false),
        .init(id: 6, genreName: "DOCUMENTARY", isSelected: false),
        .init(id: 7, genreName: "BIOGRAPHY", isSelected: false)
    ]

    // MARK: - IBOutlets
    @IBOutlet var movieImageView: UIImageView!
    @IBOutlet var releaseYearLabel: UILabel!
    @IBOutlet var ratingControl: RatingControl!
    @IBOutlet var voteCountLabel: UILabel!
    @IBOutlet var popularityLabel: UILabel!
    @IBOutlet var titleLabel: UILabel!
    @IBOutlet var durationLabel: UILabel!
    @IBOutlet var badgeCollectionView: UICollectionView!
    @IBOutlet var storylineLabel: UILabel!
    @IBOutlet var playTrailerButton: UIButton!
    @IBOutlet var rateMovieButton: UIButton!
    @IBOutlet var actorsCollectionView: UICollectionView!
    @IBOutlet var originalTitleLabel: UILabel!
    @IBOutlet var genresLabel: UILabel!
    @IBOutlet var companiesLabel: UILabel!
    @IBOutlet var releaseDateLabel: UILabel!
    @IBOutlet var movieDescriptionLabel: UILabel!
    @IBOutlet var companiesCollectionView: UICollectionView!
    @IBOutlet var similarMoviesCollectionView: UICollectionView!
    
    // MARK:  - Properties
    
    // MARK: - Lifecycles
    override func viewDidLoad() {
        super.viewDidLoad()

        setupGradientLayer()
        configureButton()
        
        [badgeCollectionView.self, actorsCollectionView.self, companiesCollectionView.self, similarMoviesCollectionView.self].forEach {
            $0?.delegate = self
            $0?.dataSource = self
        }
        
    }
    
    private func setupGradientLayer() {
        let gradientLayer = CAGradientLayer()
        gradientLayer.colors = [UIColor.clear.cgColor, UIColor(named: "Color_Dark_Blue")!.cgColor]
        gradientLayer.locations = [0, 0.8]
        movieImageView.layer.addSublayer(gradientLayer)
        
        let gradientHeight = movieImageView.frame.height * 0.5
        gradientLayer.frame = CGRect(x: 0, y: movieImageView.frame.height - gradientHeight, width: movieImageView.frame.width, height: gradientHeight)
    }
    
    private func configureButton() {
        playTrailerButton.layer.cornerRadius = playTrailerButton.frame.height / 2
        
        rateMovieButton.layer.cornerRadius = rateMovieButton.frame.height / 2
        rateMovieButton.layer.borderColor = UIColor.white.cgColor
        rateMovieButton.layer.borderWidth = 1
    }
    
    @IBAction func onPlayTrailerTapped(_ sender: Any) {
        let vc = YoutubePlayerViewController.instantiate()
        present(vc, animated: true)
    }
    
}

extension MovieDetailViewController: UICollectionViewDataSource, UICollectionViewDelegateFlowLayout {
    
    // UICollectionViewDataSource
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        if collectionView == badgeCollectionView {
            return 5
        } else if collectionView == actorsCollectionView {
            return 10
        } else if collectionView == companiesCollectionView {
            return 4
        } else {
            return 10
        }
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        if collectionView == badgeCollectionView {
            return collectionView.dequeueCell(ofType: GenreBadgeCollectionViewCell.self, for: indexPath, shouldRegister: true)
        } else if collectionView == actorsCollectionView {
            let cell = collectionView.dequeueCell(ofType: ActorCollectionViewCell.self, for: indexPath, shouldRegister: true)
            cell.delegate = self
            return cell
        } else if collectionView == companiesCollectionView {
            return collectionView.dequeueCell(ofType: CompanyCollectionViewCell.self, for: indexPath, shouldRegister: true)
        } else {
            return collectionView.dequeueCell(ofType: MovieCollectionViewCell.self, for: indexPath, shouldRegister: true)
        }
    }
    
    // UICollectionViewDelegateFlowLayout
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        if collectionView == badgeCollectionView {
            let text = genreList[indexPath.row].genreName
            let textWidth = text.getWidth(of: UIFont(name: "Geeza Pro Bold", size: 14) ?? UIFont.systemFont(ofSize: 14))
            return .init(width: textWidth + 26, height: collectionView.frame.height)
        } else if collectionView == actorsCollectionView {
            return .init(width: collectionView.frame.width * 0.35, height: collectionView.frame.height)
        } else if collectionView == companiesCollectionView {
            let width: CGFloat = 150
            return .init(width: width, height: width - 50)
        } else {
            return .init(width: collectionView.frame.width / 3, height: collectionView.frame.height)
        }
    }
    
    // Delegate
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        if collectionView == similarMoviesCollectionView {
            self.onMovieCellTapped()
        } else if collectionView == actorsCollectionView {
            self.onActorCellTapped()
        }
    }
    
}

// MARK: - Custom Delegate
extension MovieDetailViewController: MovieItemDelegate, ActorItemDelegate {
    func onFavouriteTapped(isFavourite: Bool) {
        // Todo
    }
}
