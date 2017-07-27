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
        case get(String)
        
        public var path: String {
            switch self {
            case .get(let id): return "/v3/tv/\(id)"
            }
        }
    }
    
    
}
