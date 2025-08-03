//
//  MainViewController+Delegates.swift
//  The Movies
//
//  Created by Paing Htet on 04/08/2025.
//

import UIKit

extension MainViewController: UITableViewDataSource {
    
    func numberOfSections(in tableView: UITableView) -> Int {
        return Sections.allCases.count
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return 1
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        switch indexPath.section {
        case Sections.sliderMovies.rawValue:
            let cell = dequeueTableViewCell(ofType: MovieSliderTableViewCell.self, with: tableView, for: indexPath)
            cell.movies = sliderMovies
            cell.delegate = self
            return cell
        case Sections.popularMovies.rawValue:
            let cell = dequeueTableViewCell(ofType: PopularMovieTableViewCell.self, with: tableView, for: indexPath)
            cell.sectionTitleLabel.text = "BEST POPULAR MOVIES"
            cell.movies = popularMovies
            cell.delegate = self
            return cell
        case Sections.popularSeries.rawValue:
            let cell = dequeueTableViewCell(ofType: PopularMovieTableViewCell.self, with: tableView, for: indexPath)
            cell.sectionTitleLabel.text = "BEST POPULAR SERIES"
            cell.movies = popularSeries
            cell.delegate = self
            return cell
        case Sections.checkShowtime.rawValue:
            return dequeueTableViewCell(ofType: CheckShowtimeTableViewCell.self, with: tableView, for: indexPath)
        case Sections.movieWithGenre.rawValue:
            let cell = dequeueTableViewCell(ofType: MovieWithGenreTableViewCell.self, with: tableView, for: indexPath)
            cell.genres = genres
            cell.movies = popularMovies
            cell.delegate = self
            return cell
        case Sections.showcase.rawValue:
            let cell = dequeueTableViewCell(ofType: ShowcaseTableViewCell.self, with: tableView, for: indexPath)
            cell.onMoreShowcasesTapped = { [weak self] in
                let vc = ListViewController.instantiate()
                vc.type = .movies
                vc.movieResponse = self?.movieResponse
                self?.navigationController?.pushViewController(vc, animated: true)
            }
            cell.movies = showcaseMovies
            cell.delegate = self
            return cell
        case Sections.actor.rawValue:
            let cell = dequeueTableViewCell(ofType: ActorTableViewCell.self, with: tableView, for: indexPath)
            cell.delegate = self
            cell.onMoreActorsTapped = { [weak self] in
                let vc = ListViewController.instantiate()
                vc.type = .casts
                vc.actorResponse = self?.actorResponse
                self?.navigationController?.pushViewController(vc, animated: true)
            }
            cell.actors = actors
            cell.delegate = self
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
       // TODO
    }
}
