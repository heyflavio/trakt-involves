//
//  AuthenticationModel.swift
//  trakt-involves
//
//  Created by iMac on 26/07/17.
//  Copyright © 2017 Flavio Kruger Bittencourt. All rights reserved.
//

import Foundation
import ObjectMapper

class AuthenticationModel {
    var accessToken: String?
    var expiresIn: Int? = 0
    var refreshToken: String?
    
    required convenience init?(map: Map) {
        self.init()
    }
}

extension AuthenticationModel: Mappable {
    
    func mapping(map: Map) {
        accessToken <- map["access_token"]
        expiresIn <- map["expires_in"]
        refreshToken <- map["refresh_token"]
    }
}
