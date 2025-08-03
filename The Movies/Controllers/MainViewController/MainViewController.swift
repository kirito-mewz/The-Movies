//
//  ViewController.swift
//  The Movies
//
//  Created by Paing Htet on 01/08/2025.
//

import UIKit

class MainViewController: UIViewController {
    
    // MARK: - IBOutlets
    @IBOutlet var moviesTableView: UITableView!
    
    // MARK:  - Properties
    var sliderMovies: [Movie]?
    var popularMovies: [Movie]?
    var popularSeries: [Movie]?
    var genres: [GenreVO]?
    var showcaseMovies: [Movie]?
    var actors: [Actor]?
    var movieResponse: MovieResponse?
    var actorResponse: ActorResponse?
    
    let movieModel: MovieModel = MovieModelImpl.shared
    let genreModel: GenreModel = GenreModelImpl.shared
    let actorModel: ActorModel = ActorModelImpl.shared
    
    // MARK: - Lifecycles
    override func viewDidLoad() {
        super.viewDidLoad()
        
        moviesTableView.dataSource = self
        
        [MovieSliderTableViewCell.self, PopularMovieTableViewCell.self, CheckShowtimeTableViewCell.self, MovieWithGenreTableViewCell.self,
         ShowcaseTableViewCell.self, ActorTableViewCell.self].forEach {
            moviesTableView.register(UINib(nibName: String(describing: $0), bundle: nil), forCellReuseIdentifier: String(describing: $0))
        }
        
        loadData()
        
    }

    // MARK: - Target/Action Handlers
    @IBAction private func onSearchButtonTapped(_ sender: Any) {
        guard let navVC = storyboard?.instantiateViewController(identifier: "SearchNavigationController") else {
            fatalError("Cannot find SearchNavigationController")
        }
        present(navVC, animated: true, completion: nil)
    }
    
    // MARK: - Helpers
    public enum Sections: Int, CaseIterable {
        case sliderMovies = 0
        case popularMovies = 1
        case popularSeries = 2
        case checkShowtime = 3
        case movieWithGenre = 4
        case showcase = 5
        case actor = 6
    }
    
    func updateUI(at section: Sections) {
        let indexSet = IndexSet(integer: section.rawValue)
        moviesTableView.reloadSections(indexSet, with: .automatic)
    }
    
}



