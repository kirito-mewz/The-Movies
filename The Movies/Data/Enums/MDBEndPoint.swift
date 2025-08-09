//
//  MDBEndPoint.swift
//  The Movies
//
//  Created by Paing Htet on 03/08/2025.
//

import Alamofire

enum MDBEndPoint: URLConvertible, URLRequestConvertible {
    
    // Main
    case upcomingMovies
    case popularMovies
    case popularSeries
    case genres
    case showcaseMovies(pageNo: Int = 1)
    case actors(pageNo: Int = 1)
    case searchMovies(keyword: String)
    
    // Movie Detail
    case movieDetail(movieId: Int, contentType: MovieFetchType)
    case movieTrailer(movieId: Int, contetntType: MovieFetchType)
    case movieDetailForActors(movieId: Int, contentType: MovieFetchType)
    case movieDetailForSimilarMovies(movieId: Int, contentType: MovieFetchType)
    
    // Actor Detail
    case actorDetail(actorId: Int)
    case actorDetailForMovies(actorId: Int)
    
    func asURL() throws -> URL {
        return URL(string: urlString)!
    }
    
    func asURLRequest() throws -> URLRequest {
        var request = URLRequest(url: try asURL())
        request.cachePolicy = .reloadIgnoringLocalCacheData
        return request
    }
    
    var urlString: String {
        get {
            switch self {
            case .upcomingMovies:
                return "\(baseURL)/movie/upcoming?api_key=\(apiKey)"
            case .popularMovies:
                return "\(baseURL)/movie/popular?api_key=\(apiKey)"
            case .popularSeries:
                return "\(baseURL)/tv/popular?api_key=\(apiKey)"
            case .genres:
                return "\(baseURL)/genre/movie/list?api_key=\(apiKey)"
            case .showcaseMovies(let pageNo):
                return "\(baseURL)/movie/top_rated?api_key=\(apiKey)&page=\(pageNo)"
            case .actors(let pageNo):
                return "\(baseURL)/person/popular?api_key=\(apiKey)&page=\(pageNo)"
            case .searchMovies(let keyword):
                return "\(baseURL)/search/movie?api_key=\(apiKey)&query=\(keyword)"
                
            case .movieDetail(let movieId, let type):
                return "\(baseURL)/\(type.rawValue)/\(movieId)?api_key=\(apiKey)"
            case .movieTrailer(let movieId, let type):
                return "\(baseURL)/\(type.rawValue)/\(movieId)/videos?api_key=\(apiKey)"
            case .movieDetailForActors(let movieId, let type):
                return "\(baseURL)/\(type.rawValue)/\(movieId)/credits?api_key=\(apiKey)"
            case .movieDetailForSimilarMovies(let movieId, let type):
                return "\(baseURL)/\(type.rawValue)/\(movieId)/recommendations?api_key=\(apiKey)"
                
            case .actorDetail(let actorId):
                return "\(baseURL)/person/\(actorId)?api_key=\(apiKey)"
            case .actorDetailForMovies(let actorId):
                return "\(baseURL)/person/\(actorId)/combined_credits?api_key=\(apiKey)"
            }
        }
    }
    
}
