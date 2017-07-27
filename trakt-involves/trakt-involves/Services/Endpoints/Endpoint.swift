//
//  Endpoint.swift
//  trakt-involves
//
//  Created by iMac on 26/07/17.
//  Copyright © 2017 Flavio Kruger Bittencourt. All rights reserved.
//

import Foundation

protocol Endpoint {
    var path: String { get }
    func url(authContext: Bool?) -> String
}

extension Endpoint {
    
    func url(authContext: Bool? = false) -> String {
        return "\(API.baseUrl(authContext))\(path)"
    }
}
