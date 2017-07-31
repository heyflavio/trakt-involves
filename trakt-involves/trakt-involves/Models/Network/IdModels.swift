//
//  IdModels.swift
//  trakt-involves
//
//  Created by iMac on 27/07/17.
//  Copyright © 2017 Flavio Kruger Bittencourt. All rights reserved.
//

import Foundation
import ObjectMapper

class IdModels {
    var trakt: Int = 0
    var slug: String?
    var imdb: String?
    var tvdb: Int?
    
    required convenience init?(map: Map) {
        self.init()
    }
}

extension IdModels: Mappable {
    
    func mapping(map: Map) {
        trakt <- map["trakt"]
        slug <- map["slug"]
        imdb <- map["imdb"]
        tvdb <- map["tvdb"]
    }
}
