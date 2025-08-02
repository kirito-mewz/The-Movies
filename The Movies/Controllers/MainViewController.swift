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
    
    
    // MARK: - Lifecycles
    override func viewDidLoad() {
        super.viewDidLoad()
        
        moviesTableView.dataSource = self
        
        [MovieSliderTableViewCell.self, PopularMovieTableViewCell.self, CheckShowtimeTableViewCell.self, MovieWithGenreTableViewCell.self,
         ShowcaseTableViewCell.self, ActorTableViewCell.self].forEach {
            moviesTableView.register(UINib(nibName: String(describing: $0), bundle: nil), forCellReuseIdentifier: String(describing: $0))
        }
        
    }

    // MARK: - Target/Action Handlers
    @IBAction private func onSearchButtonTapped(_ sender: Any) {
        guard let navVC = storyboard?.instantiateViewController(identifier: "SearchNavigationController") else {
            fatalError("Cannot find SearchNavigationController")
        }
        present(navVC, animated: true, completion: nil)
    }
    
    // MARK: - Helpers
    public enum Section: Int, CaseIterable {
        case sliderMovies = 0
        case popularMovies = 1
        case popularSeries = 2
        case checkShowtime = 3
        case movieWithGenre = 4
        case showcase = 5
        case actor = 6
    }
    
}

extension MainViewController: UITableViewDataSource {
    
    func numberOfSections(in tableView: UITableView) -> Int {
        return Section.allCases.count
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return 1
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        switch indexPath.section {
        case Section.sliderMovies.rawValue:
            let cell = dequeueTableViewCell(ofType: MovieSliderTableViewCell.self, with: tableView, for: indexPath)
            cell.delegate = self
            return cell
        case Section.popularMovies.rawValue:
            let cell = dequeueTableViewCell(ofType: PopularMovieTableViewCell.self, with: tableView, for: indexPath)
            cell.sectionTitleLabel.text = "Popular Movies"
            return cell
        case Section.popularSeries.rawValue:
            let cell = dequeueTableViewCell(ofType: PopularMovieTableViewCell.self, with: tableView, for: indexPath)
            cell.sectionTitleLabel.text = "Popular Series"
            return cell
        case Section.checkShowtime.rawValue:
            return dequeueTableViewCell(ofType: CheckShowtimeTableViewCell.self, with: tableView, for: indexPath)
        case Section.movieWithGenre.rawValue:
            return dequeueTableViewCell(ofType: MovieWithGenreTableViewCell.self, with: tableView, for: indexPath)
        case Section.showcase.rawValue:
            let cell = dequeueTableViewCell(ofType: ShowcaseTableViewCell.self, with: tableView, for: indexPath)
            cell.onMoreShowcasesTapped = { [weak self] in
                let vc = ListViewController.instantiate()
                vc.type = .movies
                self?.navigationController?.pushViewController(vc, animated: true)
            }
            return cell
        case Section.actor.rawValue:
            let cell = dequeueTableViewCell(ofType: ActorTableViewCell.self, with: tableView, for: indexPath)
            cell.delegate = self
            cell.onMoreActorsTapped = { [weak self] in
                let vc = ListViewController.instantiate()
                vc.type = .casts
                self?.navigationController?.pushViewController(vc, animated: true)
            }
            return cell
        default:
            return UITableViewCell()
        }
    }
    
    func dequeueTableViewCell<T: UITableViewCell>(ofType: T.Type, with tableView: UITableView, for indexPath: IndexPath, _ setupCell: ((T) -> Void) = {_ in}) -> T {
        guard let cell = tableView.dequeueReusableCell(withIdentifier: String(describing: T.self), for: indexPath) as? T else {
            fatalError("ERROR: Fail to cast the given cell into \(T.self)")
        }
        setupCell(cell)
        return cell
    }
}

// MARK: - Custom Delegate
extension MainViewController: MovieItemDelegate, ActorItemDelegate {
    func onFavouriteTapped(isFavourite: Bool) {
        debugPrint(isFavourite)
    }
}

