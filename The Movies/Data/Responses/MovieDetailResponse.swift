//
//  MovieDetailResponse.swift
//  The Movies
//
//  Created by Paing Htet on 03/08/2025.
//

import RealmSwift

// MARK: - MovieDetailResponse
struct MovieDetailResponse: Codable {
    
    let adult: Bool?
    let backdropPath: String?
    let budget: Int?
    let episodeRunTime: [Int]?
    let genres: [Genre]?
    let homepage: String?
    let id: Int?
    let imdbId, originalLanguage, originalTitle, originalName, name, overview: String?
    let popularity: Double?
    let posterPath: String?
    let productionCompanies: [ProductionCompany]?
    let productionCountries: [ProductionCountry]?
    let releaseDate, lastAirDate: String?
    let revenue, runtime: Int?
    let spokenLanguages: [SpokenLanguage]?
    let status, tagline, title: String?
    let numberOfEpisodes, numberOfSeasons: Int?
    let video: Bool?
    let voteAverage: Double?
    let voteCount: Int?
    let mediaType: String?
    
    enum CodingKeys: String, CodingKey {
        case adult
        case backdropPath = "backdrop_path"
        case budget
        case episodeRunTime = "episode_run_time"
        case genres, homepage
        case id
        case imdbId = "imdb_id"
        case originalLanguage = "original_language"
        case originalTitle = "original_title"
        case originalName = "original_name"
        case name, overview, popularity
        case posterPath = "poster_path"
        case productionCompanies = "production_companies"
        case productionCountries = "production_countries"
        case releaseDate = "release_date"
        case lastAirDate = "last_air_date"
        case revenue, runtime
        case spokenLanguages = "spoken_languages"
        case status, tagline, title
        case numberOfEpisodes = "number_of_episodes"
        case numberOfSeasons = "number_of_seasons"
        case video
        case voteAverage = "vote_average"
        case voteCount = "vote_count"
        case mediaType = "media_type"
    }
    
    func convertToMovie() -> Movie {
        Movie(
            adult: adult,
            backdropPath: backdropPath,
            genreIds: nil,
            id: id,
            originalLanguage: originalLanguage,
            originalTitle: originalTitle,
            overview: overview,
            popularity: popularity,
            posterPath: posterPath,
            releaseDate: releaseDate,
            name: name,
            title: title,
            video: video,
            voteAverage: voteAverage,
            voteCount: voteCount,
            mediaType: mediaType
        )
    }
    
    func convertToMovieDetailEmbeddedObject() -> MovieDetailEmbeddedObject {
        
        let episodeRumTimeList = List<Int>()
        episodeRunTime?.forEach { episodeRumTimeList.append($0) }
        
        let genreList = List<GenreObject>()
        genres?.map { $0.convertToGenreObject() }.forEach { genreList.append($0) }
        
        let productionCompanyList = List<ProductionCompanyEmbeddedObject>()
        productionCompanies?.map { $0.convertToProductionCompanyObject() }.forEach { productionCompanyList.append($0) }
        
        let productionCountryList = List<ProductionCountryEmbeddedObject>()
        productionCountries?.map { $0.convertToProductionCountryObject() }.forEach { productionCountryList.append($0) }
        
        let spokenLanguageList = List<SpokenLanguageEmbeddedObject>()
        spokenLanguages?.map { $0.convertToSpokenLanguageObject() }.forEach { spokenLanguageList.append($0) }
        
        let object = MovieDetailEmbeddedObject()
        object.adult = adult
        object.backdropPath = backdropPath
        object.budget = budget
        object.episodeRunTime = episodeRumTimeList
        object.genres = genreList
        object.homepage = homepage
        object.id = id
        object.imdbId = imdbId
        object.originalLanguage = originalLanguage
        object.originalTitle = originalTitle
        object.originalName = originalName
        object.name = name
        object.overview = overview
        object.popularity = popularity
        object.posterPath = posterPath
        object.productionCompanies = productionCompanyList
        object.productionCountries = productionCountryList
        object.releaseDate = releaseDate
        object.lastAirDate = lastAirDate
        object.revenue = revenue
        object.runtime = runtime
        object.spokenLanguages = spokenLanguageList
        object.status = status
        object.tagline = tagline
        object.title = title
        object.numberOfEpisodes = numberOfEpisodes
        object.numberOfSeasons = numberOfSeasons
        object.video = video
        object.voteAverage = voteAverage
        object.voteCount = voteCount
        object.mediaType = mediaType
        return object
    }
}

// MARK: - ProductionCompany
struct ProductionCompany: Codable {
    let id: Int?
    let logoPath, name, originCountry: String?
    
    enum CodingKeys: String, CodingKey {
        case id
        case logoPath = "logo_path"
        case name
        case originCountry = "origin_country"
    }
    
    func convertToProductionCompanyObject() -> ProductionCompanyEmbeddedObject {
        let object = ProductionCompanyEmbeddedObject()
        object.id = id
        object.logoPath = logoPath
        object.name = name
        object.originCountry = originCountry
        return object
    }
    
}

// MARK: - ProductionCountry
struct ProductionCountry: Codable {
    let iso3166_1, name: String?
    
    enum CodingKeys: String, CodingKey {
        case iso3166_1 = "iso_3166_1"
        case name
    }
    
    func convertToProductionCountryObject() -> ProductionCountryEmbeddedObject {
        let object = ProductionCountryEmbeddedObject()
        object.iso3166_1 = iso3166_1
        object.name = name
        return object
    }
    
}

// MARK: - SpokenLanguage
struct SpokenLanguage: Codable {
    let englishName, iso639_1, name: String?
    
    enum CodingKeys: String, CodingKey {
        case englishName = "english_name"
        case iso639_1 = "iso_639_1"
        case name
    }
    
    func convertToSpokenLanguageObject() -> SpokenLanguageEmbeddedObject {
        let object = SpokenLanguageEmbeddedObject()
        object.englishName = englishName
        object.iso639_1 = iso639_1
        object.name = name
        return object
    }
    
}

