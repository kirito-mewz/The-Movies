//
//  MainSectionModel.swift
//  The Movies
//
//  Created by Paing Htet on 10/08/2025.
//

import RxDataSources

enum MainSectionModel: SectionModelType {
    
    enum SectionItem {
        case SliderMovieSectionItems(items: [Movie])
        case PopularMovieSectionItems(items: [Movie])
        case PopularSeriesSectionItems(items: [Movie])
        case CheckShowtimeSectionItems(item: String)
        case MovieWithGenreSectionItems(items: [Movie])
        case ShowcaseMoviesSectionItem(items: [Movie])
        case ActorSectionItems(items: [Actor])
    }
    
    init(original: MainSectionModel, items: [SectionItem]) {
        switch original {
        case .SliderMovies(let items):
            self = .SliderMovies(items: items)
        case .PopularMovies(let items):
            self = .PopularMovies(items: items)
        case .PopularSeries(let items):
            self = .PopularSeries(items: items)
        case .CheckShowtime(let item):
            self = .CheckShowtime(item: item)
        case .MovieWithGenres(let items):
            self = .MovieWithGenres(items: items)
        case .ShowcaseMovies(let items):
            self = .ShowcaseMovies(items: items)
        case .Actors(let items):
            self = .Actors(items: items)
        }
    }
    
    typealias Item = SectionItem
    
    case SliderMovies(items: [SectionItem])
    case PopularMovies(items: [SectionItem])
    case PopularSeries(items: [SectionItem])
    case CheckShowtime(item: SectionItem)
    case MovieWithGenres(items: [SectionItem])
    case ShowcaseMovies(items: [SectionItem])
    case Actors(items: [SectionItem])
    
    var items: [SectionItem] {
        switch self {
        case .SliderMovies(let items):
            return items
        case .PopularMovies(let items):
            return items
        case .PopularSeries(let items):
            return items
        case .CheckShowtime(let item):
            return [item]
        case .MovieWithGenres(let items):
            return items
        case .ShowcaseMovies(let items):
            return items
        case .Actors(let items):
            return items
        }
    }
    
}
