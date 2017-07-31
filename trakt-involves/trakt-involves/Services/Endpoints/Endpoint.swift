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
    func url(authContext: Bool?, imageContext: Bool?) -> String
}

extension Endpoint {
    
    func url(authContext: Bool? = false, imageContext: Bool? = false) -> String {
        if imageContext! {
            return "\(ImageSourceAPI.baseUrl)\(path)"
        }
        return "\(API.baseUrl(authContext))\(path)"
    }
    
    public var pathDropLastSlash: String {
        return String(path.characters.dropLast(1))
    }
}
