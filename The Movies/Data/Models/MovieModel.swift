//
//  MovieModel.swift
//  The Movies
//
//  Created by Paing Htet on 03/08/2025.
//

import Foundation

protocol MovieModel {
    func getSliderMovies(pageNo: Int?,_ completion: @escaping (Result<MovieResponse, Error>) -> Void)
    func getPopularMovies(pageNo: Int?, _ completion: @escaping (Result<MovieResponse, Error>) -> Void)
    func getPopularSeries(pageNo: Int?, _ completion: @escaping (Result<MovieResponse, Error>) -> Void)
    func getShowcaseMovies(pageNo: Int?, _ completion: @escaping (Result<MovieResponse, Error>) -> Void)
    func getSearchMovies(with keyword: String, pageNo: Int, _ completion: @escaping (Result<MovieResponse, Error>) -> Void)
    
    func getMovieDetail(movieId id: Int, contentType: MovieFetchType, _ completion: @escaping (Result<MovieDetailResponse, Error>) -> Void)
    func getMovieTrailer(movieId id: Int, contentType: MovieFetchType, _ completion: @escaping (Result<Trailer, Error>) -> Void)
    func getMovieDetailForActors(movieId id: Int, contentType: MovieFetchType, _ completion: @escaping (Result<[Actor], Error>) -> Void)
    func getMovieDetailForSimilarMovies(movieId id: Int, contentType: MovieFetchType, _ completion: @escaping (Result<MovieResponse, Error>) -> Void)
}

final class MovieModelImpl: BaseModel, MovieModel {
    
    static let shared: MovieModel = MovieModelImpl()
    private let movieRepository: MovieRepository = MovieRepositoryImpl.shared
    
    private override init() {}
    
    func getSliderMovies(pageNo: Int?, _ completion: @escaping (Result<MovieResponse, any Error>) -> Void) {
        networkAgent.fetchMovies(withEndpoint: .upcomingMovies, pageNo: pageNo ?? 1) { [weak self] result in
            do {
                let response = try result.get()
        
                self?.movieRepository.saveMovies(type: .sliderMovies, pageNo: pageNo ?? 1, movies: response.movies ?? [])
                self?.movieRepository.getMovies(type: .sliderMovies, pageNo: pageNo ?? 1) { movies in
                    completion(.success(
                        MovieResponse(dates: response.dates, page: response.page, movies: movies, totalPages: response.totalPages, totalResults: response.totalResults)
                    ))
                }
                
            } catch {
                completion(.failure(error))
            }
        }
    }
    
    func getPopularMovies(pageNo: Int?, _ completion: @escaping (Result<MovieResponse, any Error>) -> Void) {
        networkAgent.fetchMovies(withEndpoint: .popularMovies, pageNo: pageNo ?? 1) { [weak self] result in
            do {
                let response = try result.get()
                
                self?.movieRepository.saveMovies(type: .popularMovies, pageNo: pageNo ?? 1, movies: response.movies ?? [])
                self?.movieRepository.getMovies(type: .popularMovies, pageNo: pageNo ?? 1) { movies in
                    completion(.success(
                        MovieResponse(dates: response.dates, page: response.page, movies: movies, totalPages: response.totalPages, totalResults: response.totalResults)
                    ))
                }
                
            } catch {
                completion(.failure(error))
            }
        }
    }
    
    func getPopularSeries(pageNo: Int?, _ completion: @escaping (Result<MovieResponse, any Error>) -> Void) {
        networkAgent.fetchMovies(withEndpoint: .popularSeries, pageNo: pageNo ?? 1) { [weak self] result in
            do {
                let response = try result.get()
                
                self?.movieRepository.saveMovies(type: .popularSeries, pageNo: pageNo ?? 1, movies: response.movies ?? [])
                self?.movieRepository.getMovies(type: .popularSeries, pageNo: pageNo ?? 1) { movies in
                    completion(.success(
                        MovieResponse(dates: response.dates, page: response.page, movies: movies, totalPages: response.totalPages, totalResults: response.totalResults)
                    ))
                }
                
            } catch {
                completion(.failure(error))
            }
        }
    }
    
    func getShowcaseMovies(pageNo: Int?, _ completion: @escaping (Result<MovieResponse, any Error>) -> Void) {
        networkAgent.fetchShowcaseMovies(withEndpoint: .showcaseMovies(pageNo: pageNo ?? 1)) { [weak self] result in
            do {
                let response = try result.get()
                
                self?.movieRepository.saveMovies(type: .showcaseMovies, pageNo: pageNo ?? 1, movies: response.movies ?? [])
                self?.movieRepository.getMovies(type: .showcaseMovies, pageNo: pageNo ?? 1) { movies in
                    completion(.success(
                        MovieResponse(dates: response.dates, page: response.page, movies: movies, totalPages: response.totalPages, totalResults: response.totalResults)
                    ))
                }
                
            } catch {
                completion(.failure(error))
            }
        }
    }
    
    func getSearchMovies(with keyword: String, pageNo: Int, _ completion: @escaping (Result<MovieResponse, any Error>) -> Void) {
        networkAgent.fetchSearchMovies(with: keyword, pageNo: pageNo) { result in
            do {
                let response = try result.get()
                completion(.success(response))
            } catch {
                completion(.failure(error))
            }
        }
    }
    
    func getMovieDetail(movieId id: Int, contentType: MovieFetchType, _ completion: @escaping (Result<MovieDetailResponse, any Error>) -> Void) {
        networkAgent.fetchMovieDetail(movieId: id, contentType: contentType) { [weak self] result in
            do {
                let response = try result.get()
            
                self?.movieRepository.saveMovieDetail(movieId: id, detail: response)
                self?.movieRepository.getMovieDetail(movieId: id) { detail in
                    completion(.success(detail))
                }
                
            } catch {
                completion(.failure(error))
            }
        }
    }
    
    func getMovieTrailer(movieId id: Int, contentType: MovieFetchType, _ completion: @escaping (Result<Trailer, any Error>) -> Void) {
        networkAgent.fetchMovieTrailer(movieId: id, contentType: contentType) { result in
            do {
                let response = try result.get()
                completion(.success(response))
            } catch {
                completion(.failure(error))
            }
        }
    }
    
    func getMovieDetailForActors(movieId id: Int, contentType: MovieFetchType, _ completion: @escaping (Result<[Actor], any Error>) -> Void) {
        networkAgent.fetchMovieDetailForActors(movieId: id, contentType: contentType) { result in
            do {
                let response = try result.get()
                completion(.success(response))
            } catch {
                completion(.failure(error))
            }
        }
    }
    
    func getMovieDetailForSimilarMovies(movieId id: Int, contentType: MovieFetchType, _ completion: @escaping (Result<MovieResponse, any Error>) -> Void) {
        networkAgent.fetchMovieDetailForSimilarMovies(movieId: id, contentType: contentType) { result in
            do {
                let response = try result.get()
                completion(.success(response))
            } catch {
                completion(.failure(error))
            }
        }
    }
    
    
}
