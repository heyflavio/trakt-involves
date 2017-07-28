//
//  Endpoint.swift
//  trakt-involves
//
//  Created by iMac on 26/07/17.
//  Copyright © 2017 Flavio Kruger Bittencourt. All rights reserved.
//

import Foundation
import Alamofire

enum Endpoints {
    
    enum Authentication: Endpoint {
        case authorize
        case getToken
        case revokeToken
        
        public var path: String {
            switch self {
            case .authorize: return "/oauth/authorize?response_type=code&client_id=\(API.clientId)&redirect_uri=\(API.redirectURI)"
            case .getToken: return "/oauth/token/"
            case .revokeToken: return "/oauth/revoke/"
            }
        }
    }
    
    enum Search: Endpoint {
        case query(String)
        
        public var path: String {
            switch self {
            case .query(let value): return "/search/show?query=\(value)"
            }
        }
    }
    
    enum Image: Endpoint {
        case get(Int)
        
        public var path: String {
            switch self {
            case .get(let id): return "/v3/tv/\(id)"
            }
        }
    }
    
    enum Show: Endpoint {
        case get(Int)
        case getWatchlist
        case addToWatchlist
        case removeFromWatchlist
        
        public var path: String {
            switch self {
            case .get(let id): return "/shows/\(id)?extended=full"
            case .getWatchlist: return "/sync/watchlist/shows"
            case .addToWatchlist: return "/sync/watchlist"
            case .removeFromWatchlist: return "/sync/watchlist/remove"

            }
        }
        
        enum Season: Endpoint {
            case getAllSeasons(Int)
            
            public var path: String {
                switch self {
                case .getAllSeasons(let id): return "/shows/\(id)/seasons?extended=full"
                }
            }
            
            enum Episode: Endpoint {
                case get(Int, Int,Int)
                case getAllEpisodes(Int, Int)
                case getNextEpisode(Int)
                case markAsWatched
                case unmarkAsWatched
                
                public var path: String {
                    switch self {
                    case .get(let id, let seasonNumber, let episodeNumber): return "/shows/\(id)/seasons/\(seasonNumber)/episodes/\(episodeNumber)?extended=full"
                    case .getAllEpisodes(let id, let seasonNumber): return "/shows/\(id)/seasons/\(seasonNumber)"
                    case .getNextEpisode(let id): return "/shows/\(id)/next_episode"
                    case .markAsWatched: return "/sync/history"
                    case .unmarkAsWatched: return "/sync/history/remove"
                    }
                }
            }
        }
        
    }
    
}
