//
//  RxMovieModel.swift
//  The Movies
//
//  Created by Paing Htet on 10/08/2025.
//

import RxSwift

protocol RxMovieModel {
    
    func getSliderMovies(pageNo: Int?) -> Observable<MovieResponse>
    func getPopularMovies(pageNo: Int?) -> Observable<MovieResponse>
    func getPopularSeries(pageNo: Int?) -> Observable<MovieResponse>
    func getShowcaseMovies(pageNo: Int?) -> Observable<MovieResponse>
    func getSearchMovies(with keyword: String, pageNo: Int) -> Observable<MovieResponse>
    
    func getMovieDetail(movieId id: Int, contentType: MovieFetchType) -> Observable<MovieDetailResponse?>
    func getMovieTrailer(movieId id: Int, contentType: MovieFetchType) -> Observable<Trailer>
    func getMovieDetailForActors(movieId id: Int, contentType: MovieFetchType) -> Observable<[Actor]>
    func getMovieDetailForSimilarMovies(movieId id: Int, contentType: MovieFetchType) -> Observable<MovieResponse>
    
}

final class RxMovieModelImpl: BaseModel, RxMovieModel {
    
    static let shared: RxMovieModel = RxMovieModelImpl()
    private let rxMovieRepo: RxMovieRepository = RxMovieRepositoryImpl.shared
    
    private override init() {}
    
    func getSliderMovies(pageNo: Int?) -> RxSwift.Observable<MovieResponse> {
        rxNetworkAgent.fetchMovies(withEndpoint: .upcomingMovies)
            .do { [weak self] response in
                self?.rxMovieRepo.saveMovies(type: .sliderMovies, pageNo: pageNo ?? 1, movies: response.movies ?? [])
            } onError: { error in
                print("\(#function) \(error)")
            }
            .flatMap { reponse -> Observable<MovieResponse> in
                return self.rxMovieRepo.getMovies(type: .sliderMovies, pageNo: pageNo ?? 1)
                    .flatMap { movies in
                        return Observable.of(MovieResponse(dates: reponse.dates, page: reponse.page, movies: movies, totalPages: reponse.totalPages, totalResults: reponse.totalResults))
                    }
            }
    }
    
    func getPopularMovies(pageNo: Int?) -> RxSwift.Observable<MovieResponse> {
        rxNetworkAgent.fetchMovies(withEndpoint: .popularMovies)
            .do { [weak self] response in
                self?.rxMovieRepo.saveMovies(type: .popularMovies, pageNo: pageNo ?? 1, movies: response.movies ?? [])
            } onError: { error in
                print("\(#function) \(error)")
            }
            .flatMap { reponse -> Observable<MovieResponse> in
                return self.rxMovieRepo.getMovies(type: .popularMovies, pageNo: pageNo ?? 1)
                    .flatMap { movies in
                        return Observable.of(MovieResponse(dates: reponse.dates, page: reponse.page, movies: movies, totalPages: reponse.totalPages, totalResults: reponse.totalResults))
                    }
            }
    }
    
    func getPopularSeries(pageNo: Int?) -> RxSwift.Observable<MovieResponse> {
        rxNetworkAgent.fetchMovies(withEndpoint: .popularSeries)
            .do { [weak self] response in
                self?.rxMovieRepo.saveMovies(type: .popularSeries, pageNo: pageNo ?? 1, movies: response.movies ?? [])
            } onError: { error in
                print("\(#function) \(error)")
            }
            .flatMap { reponse -> Observable<MovieResponse> in
                return self.rxMovieRepo.getMovies(type: .popularSeries, pageNo: pageNo ?? 1)
                    .flatMap { movies in
                        return Observable.of(MovieResponse(dates: reponse.dates, page: reponse.page, movies: movies, totalPages: reponse.totalPages, totalResults: reponse.totalResults))
                    }
            }
    }
    
    func getShowcaseMovies(pageNo: Int?) -> RxSwift.Observable<MovieResponse> {
        rxNetworkAgent.fetchMovies(withEndpoint: .showcaseMovies(pageNo: pageNo ?? 1))
            .do { [weak self] response in
                self?.rxMovieRepo.saveMovies(type: .showcaseMovies, pageNo: pageNo ?? 1, movies: response.movies ?? [])
            } onError: { error in
                print("\(#function) \(error)")
            }
            .flatMap { reponse -> Observable<MovieResponse> in
                return self.rxMovieRepo.getMovies(type: .showcaseMovies, pageNo: pageNo ?? 1)
                    .flatMap { movies in
                        return Observable.of(MovieResponse(dates: reponse.dates, page: reponse.page, movies: movies, totalPages: reponse.totalPages, totalResults: reponse.totalResults))
                    }
            }
    }
    
    func getSearchMovies(with keyword: String, pageNo: Int) -> RxSwift.Observable<MovieResponse> {
        rxNetworkAgent.fetchSearchMovies(with: keyword, pageNo: pageNo)
    }
    
    func getMovieDetail(movieId id: Int, contentType: MovieFetchType) -> RxSwift.Observable<MovieDetailResponse?> {
        rxNetworkAgent.fetchMovieDetail(movieId: id, contentType: contentType)
            .do { [weak self] response in
                self?.rxMovieRepo.saveMovieDetail(movieId: id, detail: response)
            } onError: { error in
                print("\(#function) \(error)")
            }
            .flatMap { response -> Observable<MovieDetailResponse?> in
                self.rxMovieRepo.getMovieDetail(movieId: response.id ?? -1)
            }
    }
    
    func getMovieTrailer(movieId id: Int, contentType: MovieFetchType) -> RxSwift.Observable<Trailer> {
        rxNetworkAgent.fetchMovieTrailer(movieId: id, contentType: contentType)
    }
    
    func getMovieDetailForActors(movieId id: Int, contentType: MovieFetchType) -> RxSwift.Observable<[Actor]> {
        rxNetworkAgent.fetchMovieDetailForActors(movieId: id, contentType: contentType)
    }
    
    func getMovieDetailForSimilarMovies(movieId id: Int, contentType: MovieFetchType) -> RxSwift.Observable<MovieResponse> {
        rxNetworkAgent.fetchMovieDetailForSimilarMovies(movieId: id, contentType: contentType)
    }
    
    

    
    
}
