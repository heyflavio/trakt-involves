//
//  EpisodeModel.swift
//  trakt-involves
//
//  Created by iMac on 28/07/17.
//  Copyright © 2017 Flavio Kruger Bittencourt. All rights reserved.
//

import Foundation
import ObjectMapper
import RealmSwift

class EpisodeModel: Object, RealmObject {
    
    dynamic var id = 0
    dynamic var season = 0
    dynamic var number = 0
    dynamic var title: String?
    dynamic var overview: String?
    dynamic var firstAired: Date?
    dynamic var show: ShowModel?
    var ids: IdModels?
    
    
    required convenience init?(map: Map) {
        self.init()
    }
    
    override static func primaryKey() -> String? {
        return "id"
    }
    
    override static func ignoredProperties() -> [String] {
        return ["ids"]
    }
}

extension EpisodeModel: Mappable {
    
    func mapping(map: Map) {
        season <- map["season"]
        number <- map["number"]
        ids <- map["ids"]
        title <- map["title"]
        overview <- map["overview"]
        firstAired <- (map["first_aired"], DateTransformer())
    }
}
