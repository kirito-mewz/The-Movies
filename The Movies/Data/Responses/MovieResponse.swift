//
//  MovieResponse.swift
//  The Movies
//
//  Created by Paing Htet on 03/08/2025.
//

import Foundation

// MARK: - MovieResponse
struct MovieResponse: Codable {
    let dates: Dates?
    let page: Int?
    let movies: [Movie]?
    let totalPages, totalResults: Int?
    
    enum CodingKeys: String, CodingKey {
        case dates, page
        case movies = "results"
        case totalPages = "total_pages"
        case totalResults = "total_results"
    }
}

// MARK: - Dates
struct Dates: Codable {
    let maximum, minimum: String?
}

// MARK: - Movie
struct Movie: Codable, Hashable {
    let adult: Bool?
    let backdropPath: String?
    let genreIds: [Int]?
    let id: Int?
    let originalLanguage, originalTitle, overview: String?
    let popularity: Double?
    let posterPath, releaseDate, name, title: String?
    let video: Bool?
    let voteAverage: Double?
    let voteCount: Int?
    let mediaType: String?
    
    enum CodingKeys: String, CodingKey {
        case adult
        case backdropPath = "backdrop_path"
        case genreIds = "genre_ids"
        case id
        case originalLanguage = "original_language"
        case originalTitle = "original_title"
        case overview, popularity
        case posterPath = "poster_path"
        case releaseDate = "release_date"
        case name, title, video
        case voteAverage = "vote_average"
        case voteCount = "vote_count"
        case mediaType = "media_type"
    }
    
    func convertToMovieObject(type: MovieDisplayType, pageNo: Int = 1) -> MovieObject {
        let object = MovieObject()
        object.adult = adult
        object.backdropPath = backdropPath
        object.genreIds = genreIds?.map { String($0) }.joined(separator: ",") ?? ""
        object.id = id
        object.originalLanguage = originalLanguage
        object.originalTitle = originalTitle
        object.overview = overview
        object.popularity = popularity
        object.posterPath = posterPath
        object.releaseDate = releaseDate
        object.name = name
        object.title = title
        object.video = video
        object.voteAverage = voteAverage
        object.voteCount = voteCount
        object.mediaType = mediaType
        object.displayType = type
        object.pageNo = pageNo
        return object
    }
}

// MARK: - MovieGenres
struct MovieGenre: Codable {
    let genres: [Genre]?
}

// MARK: - Genre
struct Genre: Codable {
    let id: Int?
    let name: String?
    
    func convertToGenreVO() -> GenreVO {
        GenreVO(id: id ?? 0, genreName: name ?? "", isSelected: false)
    }
    
    func convertToGenreObject() -> GenreObject {
        let object = GenreObject()
        object.id = id
        object.name = name
        return object
    }
}
