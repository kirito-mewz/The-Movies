//
//  RxGenreModel.swift
//  The Movies
//
//  Created by Paing Htet on 10/08/2025.
//

import RxSwift

protocol RxGenreModel {
    
    func getGenres() -> Observable<[Genre]>
    
}

final class RxGenreModelImpl: BaseModel, RxGenreModel {
    
    static let shared: RxGenreModel = RxGenreModelImpl()
    
    private let rxGenreRepo = RxGenreRepositoryImpl.shared
    private let disposeBag = DisposeBag()
    
    private override init() {}
    
    func getGenres() -> RxSwift.Observable<[Genre]> {
        rxNetworkAgent.fetchGenres(withEndpoint: .genres)
            .subscribe { genres in
                self.rxGenreRepo.saveGenres(genres: genres)
            } onError: { error in
                print("\(#function) \(error)")
            }
            .disposed(by: disposeBag)
        return self.rxGenreRepo.getGenres()
    }
    

}
