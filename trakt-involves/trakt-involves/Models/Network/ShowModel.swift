//
//  ShowModel.swift
//  trakt-involves
//
//  Created by iMac on 27/07/17.
//  Copyright © 2017 Flavio Kruger Bittencourt. All rights reserved.
//

import Foundation
import ObjectMapper
import RealmSwift

class ShowModel: Object, RealmObject {
    
    dynamic var id = 0
    dynamic var title: String?
    dynamic var year = 0
    dynamic var overview: String?
    dynamic var network: String?
    dynamic var airedEpisodes = 0
    var episodes = LinkingObjects(fromType: EpisodeModel.self, property: "show")
    dynamic fileprivate var showContext = ShowContext.none.rawValue
    var ids: IdModels?
    
    var context: ShowContext {
        get {
            return ShowContext(rawValue: showContext)!
        }
        set {
            showContext = newValue.rawValue
        }
    }
    
    required convenience init?(map: Map) {
        self.init()
    }
    
    override static func primaryKey() -> String? {
        return "id"
    }
    
    override static func ignoredProperties() -> [String] {
        return ["ids", "overview", "network", "airedEpisodes", "context"]
    }
}

extension ShowModel: Mappable {
    
    func mapping(map: Map) {
        id <- map["id"]
        title <- map["title"]
        year <- map["year"]
        ids <- map["ids"]
        overview <- map["overview"]
        network <- map["network"]
        airedEpisodes <- map["aired_episodes"]
        showContext <- map["showContext"]
    }
}
