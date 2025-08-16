//
//  ListViewController.swift
//  The Movies
//
//  Created by Paing Htet on 01/08/2025.
//

import UIKit
import RxSwift

class ListViewController: UIViewController, Storyboarded {
    
    enum ListType {
        case movies
        case casts
    }

    // MARK: - IBOutlets
    @IBOutlet var collectionView: UICollectionView!
    @IBOutlet var upButton: UIButton!
    
    // MARK:  - Properties
    var type: ListType = .movies
    
    var noOfCols: CGFloat = 2
    var spacing: CGFloat = 10
    
    var movieResponse: MovieResponse?
    var actorResponse: ActorResponse?
    
    var movies: [Movie] = []
    var actors: [Actor] = []

    var currentPage = 1
    var totalPages = 1
    
    let movieModel: MovieModel = MovieModelImpl.shared
    let actorModel: ActorModel = ActorModelImpl.shared
    
    var observableNoOfPages: Observable<Int> = .just(1)
    lazy var observableMovieList: BehaviorSubject<[Movie]> = BehaviorSubject(value: [])
    lazy var observableActorList: BehaviorSubject<[Actor]> = BehaviorSubject(value: [])
    
    // MARK: - Lifecycles
    override func viewDidLoad() {
        super.viewDidLoad()
        
        navigationItem.title = type == .movies ? "All Showcase Movies" : "All Actors"
        
        setupButton()
        setupInitialData()
        
        collectionView.delegate = self
        collectionView.dataSource = self

    }
    
    // MARK: - Helpers
    private func setupButton() {
        let upImage = UIImage(systemName: "chevron.up.circle.fill", withConfiguration: UIImage.SymbolConfiguration(font: .systemFont(ofSize: 36)))
        upButton.setImage(upImage, for: .normal)
        upButton.transform = CGAffineTransform(scaleX: 0, y: 0)
    }
    
    private func setupInitialData() {
        if type == .movies {
            movieResponse?.movies?.forEach { movies.append($0) }
            currentPage = movieResponse?.page ?? 1
            totalPages = movieResponse?.totalPages ?? 1
        } else {
            actorResponse?.actors?.forEach { actors.append($0) }
            currentPage = actorResponse?.page ?? 1
            totalPages = actorResponse?.totalPages ?? 1
        }
        collectionView.reloadData()
    }
    
    // MARK: - Target/Action Handlers
    @IBAction func onUpButtonTapped(_ sender: Any) {
        collectionView.scrollToItem(at: IndexPath(item: 0, section: 0), at: .top, animated: true)
    }

}



