//
//  MainViewController+Data.swift
//  The Movies
//
//  Created by Paing Htet on 04/08/2025.
//

import Foundation

extension MainViewController {
    
    func loadData() {
        
        // Fetch Slider Movies
        movieModel.getSliderMovies(pageNo: nil) { [weak self] result in
            do {
                self?.sliderMovies = try result.get().movies
                self?.updateUI(at: .sliderMovies)
            } catch {
                print("[Error: while fetching UpComingMovies]", error)
            }
        }
        
        // Fetch Slider Movies
        movieModel.getPopularMovies(pageNo: nil) { [weak self] result in
            do {
                self?.popularMovies = try result.get().movies
                self?.updateUI(at: .popularMovies)
            } catch {
                print("[Error: while fetching PopularMovies]", error)
            }
        }
        
        // Fetch Slider Series
        movieModel.getPopularSeries(pageNo: nil) { [weak self] result in
            do {
                self?.popularSeries = try result.get().movies
                self?.updateUI(at: .popularSeries)
            } catch {
                print("[Error: while fetching PopularSeries]", error)
            }
        }
        
        // Fetch Genre
        genreModel.getGenres { [weak self] result in
            do {
                self?.genres = try result.get().map { $0.convertToGenreVO() }
                self?.updateUI(at: .movieWithGenre)
            } catch {
                print("[Error: while fetching Genres]", error)
            }
        }
        
        // Fetch Showcase Movies
        movieModel.getShowcaseMovies(pageNo: nil) { [weak self] result in
            do {
                self?.movieResponse = try result.get()
                self?.showcaseMovies = self?.movieResponse?.movies
                self?.updateUI(at: .showcase)
            } catch {
                print("[Error: while fetching Showcase Movies]", error)
            }
        }
        
        // Fetch Actors
        actorModel.getActors(pageNo: nil) { [weak self] result in
            do {
                self?.actorResponse = try result.get()
                self?.actors = self?.actorResponse?.actors
                self?.updateUI(at: .actor)
            } catch {
                print("[Error: while fetching Actors]", error)
            }
        }
        
    }
    
}
