//
//  MovieDisplayType.swift
//  The Movies
//
//  Created by Paing Htet on 09/08/2025.
//

import RealmSwift

enum MovieDisplayType: String, CaseIterable, PersistableEnum {
    
    case sliderMovies = "Slider Movies"
    case popularMovies = "Popular Movies"
    case popularSeries = "Popular Series"
    case movieWithGenres = "Movie With Genres"
    case showcaseMovies = "Showcase Movies"
    case similarMoves = "Similar Movies"
    case others = "Others"
    
}
