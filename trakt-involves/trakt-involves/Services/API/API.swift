//
//  API.swift
//  trakt-involves
//
//  Created by iMac on 26/07/17.
//  Copyright © 2017 Flavio Kruger Bittencourt. All rights reserved.
//

import Foundation

struct API {
    
    static func baseUrl(_ authContext: Bool? = false) -> String {
        if authContext! {
            return "https://trakt.tv"
        }
        return "https://api.trakt.tv"
    }
    static let clientId = "7b705200e29b4ed2388862e1dc2370e9ef6bca97bdf8e9d670e6b119ba55beaf"
    static let clientSecret = "e94aec7a0ac764d1ab03f8f7c10712be606b954c197368302b1c45b7a9085cc8"
    static let redirectURI = "trakt-involves://oauth-callback"
    
}
