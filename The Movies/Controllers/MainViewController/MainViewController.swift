//
//  ViewController.swift
//  The Movies
//
//  Created by Paing Htet on 01/08/2025.
//

import UIKit
import RxSwift
import RxDataSources

class MainViewController: UIViewController {
    
    // MARK: - IBOutlets
    @IBOutlet var moviesTableView: UITableView!
    
    // MARK:  - Properties
//    var sliderMovies: [Movie]?
//    var popularMovies: [Movie]?
//    var popularSeries: [Movie]?
//    var genres: [GenreVO]?
//    var showcaseMovies: [Movie]?
//    var actors: [Actor]?
//    var movieResponse: MovieResponse?
//    var actorResponse: ActorResponse?
//    
//    let movieModel: MovieModel = MovieModelImpl.shared
//    let genreModel: GenreModel = GenreModelImpl.shared
//    let actorModel: ActorModel = ActorModelImpl.shared
    
    var observableSliderMovies: BehaviorSubject<[Movie]> = BehaviorSubject(value: [])
    var observablePopularMovies: BehaviorSubject<[Movie]> = BehaviorSubject(value: [])
    var observablePopularSeries: BehaviorSubject<[Movie]> = BehaviorSubject(value: [])
    var observableGenres: BehaviorSubject<[GenreVO]> = BehaviorSubject(value: [])
    var observableShowcaseMovieResponse: BehaviorSubject<MovieResponse?> = BehaviorSubject(value: nil)
    var observableActorResponse: BehaviorSubject<ActorResponse?> = BehaviorSubject(value: nil)
    
    var datasource: RxTableViewSectionedReloadDataSource<MainSectionModel>!
    
    let rxMovieModel: RxMovieModel = RxMovieModelImpl.shared
    let rxGenreModel: RxGenreModel = RxGenreModelImpl.shared
    let rxActorModel: RxActorModel = RxActorModelImpl.shared
    
    let disposeBag: DisposeBag = DisposeBag()
    
    // MARK: - Lifecycles
    override func viewDidLoad() {
        super.viewDidLoad()
        
        // moviesTableView.dataSource = self
        
        [MovieSliderTableViewCell.self,
         PopularMovieTableViewCell.self,
         CheckShowtimeTableViewCell.self,
         MovieWithGenreTableViewCell.self,
         ShowcaseTableViewCell.self,
         ActorTableViewCell.self
        ].forEach {
            moviesTableView.register(UINib(nibName: String(describing: $0), bundle: nil), forCellReuseIdentifier: String(describing: $0))
        }
        
        // loadData()
        rxLoadData()
        
        self.datasource = initDataSource()
        bindModelWithDataSource()
        
    }

    // MARK: - Target/Action Handlers
    @IBAction private func onSearchButtonTapped(_ sender: Any) {
        guard let navVC = storyboard?.instantiateViewController(identifier: "SearchNavigationController") else {
            fatalError("Cannot find SearchNavigationController")
        }
        present(navVC, animated: true, completion: nil)
    }
    
    // MARK: - Helpers
//    public enum Sections: Int, CaseIterable {
//        case sliderMovies = 0
//        case popularMovies = 1
//        case popularSeries = 2
//        case checkShowtime = 3
//        case movieWithGenre = 4
//        case showcase = 5
//        case actor = 6
//    }
//    
//    func updateUI(at section: Sections) {
//        let indexSet = IndexSet(integer: section.rawValue)
//        moviesTableView.reloadSections(indexSet, with: .automatic)
//    }
    
    fileprivate func bindModelWithDataSource() {
        
        let combindedObservable = Observable.combineLatest(
            observableSliderMovies,
            observablePopularMovies,
            observablePopularSeries,
            observableShowcaseMovieResponse.flatMap { Observable.just($0?.movies ?? []) },
            observableActorResponse.flatMap { Observable.just($0?.actors ?? []) }
        )
 
        combindedObservable
        .flatMapLatest { (sliderMovies, popularMovies, popularSeries, showcaseMovies, actors) -> Observable<[MainSectionModel]> in
            
            var items = [MainSectionModel]()
            
            if !sliderMovies.isEmpty {
                items.append(.SliderMovies(items: [.SliderMovieSectionItems(items: sliderMovies)]))
            }
            
            if !popularMovies.isEmpty {
                items.append(.PopularMovies(items: [.PopularMovieSectionItems(items: popularMovies)]))
            }
            
            if !popularSeries.isEmpty {
                items.append(.PopularSeries(items: [.PopularSeriesSectionItems(items: popularSeries)]))
            }
            
            items.append(.CheckShowtime(item: .CheckShowtimeSectionItems(item: "")))
            
            items.append(.MovieWithGenres(items: [.MovieWithGenreSectionItems(items: popularMovies)]))
            
            if !showcaseMovies.isEmpty {
                items.append(.ShowcaseMovies(items: [.ShowcaseMoviesSectionItem(items: showcaseMovies)]))
            }
            
            if !actors.isEmpty {
                items.append(.Actors(items: [.ActorSectionItems(items: actors)]))
            }
            
            return .just(items)
            
        }
        .bind(to: moviesTableView.rx.items(dataSource: datasource))
        .disposed(by: disposeBag)
    }
    
    
}



