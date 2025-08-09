//
//  GenreModel.swift
//  The Movies
//
//  Created by Paing Htet on 03/08/2025.
//

import Foundation

protocol GenreModel {
    func getGenres(completion: @escaping (Result<[Genre], Error>) -> Void)
}

final class GenreModelImpl: BaseModel, GenreModel {
    
    static let shared: GenreModel = GenreModelImpl()
    private let genreRepository: GenreRepository = GenreRepositoryImpl.shared
    
    private override init() {}
    
    func getGenres(completion: @escaping (Result<[Genre], any Error>) -> Void) {
        networkAgent.fetchGenres(withEndpoint: .genres) { [weak self] result in
            do {
                let response = try result.get()
                
                self?.genreRepository.saveGenres(genres: response)
                self?.genreRepository.getGenres { completion(.success($0)) }
                
            } catch {
                completion(.failure(error))
            }
        }
    }

}
