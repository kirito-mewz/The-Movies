//
//  MainViewController+Data.swift
//  The Movies
//
//  Created by Paing Htet on 04/08/2025.
//

import Foundation
import RxDataSources

extension MainViewController {
    
    // MARK: - Load data from model
    func rxLoadData() {
        loadSliderMovies()
        loadPopularMovies()
        loadPopularSeries()
        loadMovieGenre()
        loadShowcaseMovies()
        loadActors()
    }
    
    // Fetch Slider Movies
    fileprivate func loadSliderMovies() {
        rxMovieModel.getSliderMovies(pageNo: nil)
            .subscribe { [weak self] response in
                self?.observableSliderMovies.onNext(response.movies ?? [])
            } onError: { error in
                print("\(#function) \(error)")
            }
            .disposed(by: disposeBag)
    }
    
    // Fetch Popular Movies
    fileprivate func loadPopularMovies() {
        rxMovieModel.getPopularMovies(pageNo: nil)
            .subscribe { [weak self] response in
                self?.observablePopularMovies.onNext(response.movies ?? [])
            } onError: { error in
                print("\(#function) \(error)")
            }
            .disposed(by: disposeBag)
    }
    
    // Fetch Popular Series
    fileprivate func loadPopularSeries() {
        rxMovieModel.getPopularSeries(pageNo: nil)
            .subscribe { [weak self] response in
                self?.observablePopularSeries.onNext(response.movies ?? [])
            } onError: { error in
                print("\(#function) \(error)")
            }
            .disposed(by: disposeBag)
    }
    
    // Fetch Genres
    fileprivate func loadMovieGenre() {
        rxGenreModel.getGenres()
            .map { genres -> [GenreVO] in
                genres.map { $0.convertToGenreVO() }
            }
            .subscribe { genresVO in
                self.observableGenres.onNext(genresVO)
            } onError: { error in
                print("\(#function) \(error)")
            }
            .disposed(by: disposeBag)
    }
    
    // Fetch Showcase Movies
    fileprivate func loadShowcaseMovies() {
        rxMovieModel.getShowcaseMovies(pageNo: nil)
            .subscribe { [weak self] response in
                self?.observableShowcaseMovieResponse.onNext(response)
            } onError: { error in
                print("\(#function) \(error)")
            }
            .disposed(by: disposeBag)
    }
    
    // Fetch Actors
    fileprivate func loadActors() {
        rxActorModel.getActors(pageNo: 1)
            .subscribe { [weak self] response in
                self?.observableActorResponse.onNext(response)
            } onError: { error in
                print("\(#function) \(error)")
            }
            .disposed(by: disposeBag)
    }
    
    
    // MARK: - Init RxTableViewSectionedReloadDataSource
    func initDataSource() -> RxTableViewSectionedReloadDataSource<MainSectionModel> {
        RxTableViewSectionedReloadDataSource<MainSectionModel> { dataSource, tableView, indexPath, item in
            switch item {
            case .SliderMovieSectionItems(let items):
                let cell = self.dequeueTableViewCell(ofType: MovieSliderTableViewCell.self, with: tableView, for: indexPath)
                cell.delegate = self
                cell.movies = items
                return cell
            case .PopularMovieSectionItems(let items):
                let cell = self.dequeueTableViewCell(ofType: PopularMovieTableViewCell.self, with: tableView, for: indexPath)
                cell.delegate = self
                cell.sectionTitleLabel.text = "BEST POPULAR MOVIES"
                cell.movies = items
                return cell
            case .PopularSeriesSectionItems(let items):
                let cell = self.dequeueTableViewCell(ofType: PopularMovieTableViewCell.self, with: tableView, for: indexPath)
                cell.delegate = self
                cell.sectionTitleLabel.text = "BEST POPULAR SERIES"
                cell.movies = items
                return cell
            case .CheckShowtimeSectionItems(_):
                return self.dequeueTableViewCell(ofType: CheckShowtimeTableViewCell.self, with: tableView, for: indexPath)
            case .MovieWithGenreSectionItems(let items):
                let cell = self.dequeueTableViewCell(ofType: MovieWithGenreTableViewCell.self, with: tableView, for: indexPath)
                cell.movies = items
                cell.delegate = self
                cell.genres = try! self.observableGenres.value()
                return cell
            case .ShowcaseMoviesSectionItem(let items):
                let cell = self.dequeueTableViewCell(ofType: ShowcaseTableViewCell.self, with: tableView, for: indexPath)
                cell.movies = items
                cell.delegate = self
                cell.onMoreShowcasesTapped = {
                    let vc = ListViewController.instantiate()
                    vc.type = .movies
                    self.observableShowcaseMovieResponse
                        .do { data in
                            vc.observableNoOfPages = .just(data?.totalPages ?? 1)
                        }
                        .compactMap { $0?.movies }
                        .subscribe { data in
                            vc.observableMovieList.onNext(data)
                        } onError: { error in
                            print("\(#function) \(error)")
                        }
                        .disposed(by: self.disposeBag)
                    self.navigationController?.pushViewController(vc, animated: true)
                }
                return cell
            case .ActorSectionItems(let items):
                let cell = self.dequeueTableViewCell(ofType: ActorTableViewCell.self, with: tableView, for: indexPath)
                cell.actors = items
                cell.delegate = self
                cell.onMoreActorsTapped = {
                    let vc = ListViewController.instantiate()
                    vc.type = .casts
                    self.observableActorResponse
                        .do { data in
                            vc.observableNoOfPages = .just(data?.totalPages ?? 1)
                        }
                        .compactMap { $0?.actors }
                        .subscribe { data in
                            vc.observableActorList.onNext(data)
                        } onError: { error in
                            print("\(#function) \(error)")
                        }
                        .disposed(by: self.disposeBag)
                    self.navigationController?.pushViewController(vc, animated: true)
                }
                return cell
            }
        }
    }
    
    private func dequeueTableViewCell<T: UITableViewCell>(ofType: T.Type, with tableView: UITableView, for indexPath: IndexPath, _ setupCell: ((T) -> Void) = {_ in}) -> T {
        guard let cell = tableView.dequeueReusableCell(withIdentifier: String(describing: T.self), for: indexPath) as? T else {
            fatalError("ERROR: Fail to cast the given cell into \(T.self)")
        }
        setupCell(cell)
        return cell
    }
    
    
//    func loadData() {
//
//        // Fetch Slider Movies
//        movieModel.getSliderMovies(pageNo: nil) { [weak self] result in
//            do {
//                self?.sliderMovies = try result.get().movies
//                self?.updateUI(at: .sliderMovies)
//            } catch {
//                print("[Error: while fetching UpComingMovies]", error)
//            }
//        }
//
//        // Fetch Slider Movies
//        movieModel.getPopularMovies(pageNo: nil) { [weak self] result in
//            do {
//                self?.popularMovies = try result.get().movies
//                self?.updateUI(at: .popularMovies)
//            } catch {
//                print("[Error: while fetching PopularMovies]", error)
//            }
//        }
//
//        // Fetch Slider Series
//        movieModel.getPopularSeries(pageNo: nil) { [weak self] result in
//            do {
//                self?.popularSeries = try result.get().movies
//                self?.updateUI(at: .popularSeries)
//            } catch {
//                print("[Error: while fetching PopularSeries]", error)
//            }
//        }
//
//        // Fetch Genre
//        genreModel.getGenres { [weak self] result in
//            do {
//                self?.genres = try result.get().map { $0.convertToGenreVO() }
//                self?.updateUI(at: .movieWithGenre)
//            } catch {
//                print("[Error: while fetching Genres]", error)
//            }
//        }
//
//        // Fetch Showcase Movies
//        movieModel.getShowcaseMovies(pageNo: nil) { [weak self] result in
//            do {
//                self?.movieResponse = try result.get()
//                self?.showcaseMovies = self?.movieResponse?.movies
//                self?.updateUI(at: .showcase)
//            } catch {
//                print("[Error: while fetching Showcase Movies]", error)
//            }
//        }
//
//        // Fetch Actors
//        actorModel.getActors(pageNo: nil) { [weak self] result in
//            do {
//                self?.actorResponse = try result.get()
//                self?.actors = self?.actorResponse?.actors
//                self?.updateUI(at: .actor)
//            } catch {
//                print("[Error: while fetching Actors]", error)
//            }
//        }
//
//    }
    
    
}
