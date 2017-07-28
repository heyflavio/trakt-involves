//
//  EpisodeModel.swift
//  trakt-involves
//
//  Created by iMac on 28/07/17.
//  Copyright © 2017 Flavio Kruger Bittencourt. All rights reserved.
//

import Foundation
import ObjectMapper

class EpisodeModel {
    var season: Int?
    var number: Int?
    var ids: IdModels?
    var title: String?
    var overview: String?
    
    required convenience init?(map: Map) {
        self.init()
    }
}

extension EpisodeModel: Mappable {
    
    func mapping(map: Map) {
        season <- map["season"]
        number <- map["number"]
        ids <- map["ids"]
        title <- map["title"]
        overview <- map["overview"]
    }
}
