//
//  MovieDetailViewController.swift
//  The Movies
//
//  Created by Paing Htet on 01/08/2025.
//

import UIKit
import SDWebImage
import RxSwift

class MovieDetailViewController: UIViewController, Storyboarded {

    // MARK: - IBOutlets
    @IBOutlet var movieImageView: UIImageView!
    @IBOutlet var releaseYearLabel: UILabel!
    @IBOutlet var ratingControl: RatingControl!
    @IBOutlet var voteCountLabel: UILabel!
    @IBOutlet var popularityLabel: UILabel!
    @IBOutlet var movieTitleLabel: UILabel!
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
    var movieId: Int = -1 {
        didSet {
            rxLoadData()
        }
    }
    
    var contentType: MovieFetchType = .movie
    
    var detail: MovieDetailResponse?
    var actors: [Actor]?
    var companies: [ProductionCompany]?
    var similarMovies: [Movie]?
    
    let rxMovieModel: RxMovieModel = RxMovieModelImpl.shared
    
    let disposeBag: DisposeBag = DisposeBag()
    
    // MARK: - Lifecycles
    override func viewDidLoad() {
        super.viewDidLoad()

        setupGradientLayer()
        configureButton()
        
        [badgeCollectionView.self, actorsCollectionView.self, companiesCollectionView.self, similarMoviesCollectionView.self].forEach {
            $0?.delegate = self
            $0?.dataSource = self
        }
        // loadData()
        // rxLoadData()
        
    }
    
    // MARK: - Target/Action Handlers
    @IBAction func onPlayTrailerTapped(_ sender: Any) {
//        self.downloadTrailer()
        self.rxDownloadTrailer()
    }
    
    // MARK: - Helpers
    func bindData(with detail: MovieDetailResponse?) {
        
        guard let data = detail else { return }
        
        if let imagePath = data.backdropPath {
            movieImageView.sd_setImage(with: URL(string: "\(imageBaseURL)/\(imagePath)"))
        }
        
        if contentType == .movie {
            
            releaseYearLabel.text = String(data.releaseDate?.split(separator: "-").first ?? "")
            movieTitleLabel.text = data.title
            originalTitleLabel.text = data.originalTitle
            releaseDateLabel.text = data.releaseDate
            
            let hour = (data.runtime ?? 0) / 60
            let minute = (data.runtime ?? 0) - hour * 60
            let duration = "\(hour)h \(minute)min"
            durationLabel.text = duration
            
        } else {
            
            releaseYearLabel.text = String(data.lastAirDate?.split(separator: "-").first ?? "")
            movieTitleLabel.text = data.name
            originalTitleLabel.text = data.originalName
            releaseDateLabel.text = data.lastAirDate
            
            let duration = "\(data.numberOfSeasons ?? 1) \((data.numberOfSeasons ?? 1) > 1 ? "Seasons" : "Season")"
            durationLabel.text = duration
            
        }
        
        voteCountLabel.text = "\(data.voteCount ?? 0) VOTES"
        ratingControl.rating = Int(round(data.voteAverage ?? 0) * 0.5)
        popularityLabel.text = String(format: "%.1f", data.popularity ?? 0)
        storylineLabel.text = data.overview
        
        var rawGenres = data.genres?.map { $0.name }.reduce("") { "\($0 ?? "") \($1 ?? ""), " } ?? ""
        if (rawGenres.count) >= 2 {
            rawGenres.removeLast(2)
        }
        genresLabel.text = rawGenres
        
        var rawCompanies = data.productionCompanies?.map { $0.name }.reduce("") { "\($0 ?? "") \($1 ?? ""), " } ?? ""
        if (rawCompanies.count) >= 2 {
            rawCompanies.removeLast(2)
        }
        companiesLabel.text = rawCompanies
        
        movieDescriptionLabel.text = data.overview
        
        companies = data.productionCompanies
        
        badgeCollectionView.reloadData()
        companiesCollectionView.reloadData()
        
    }
    
}
