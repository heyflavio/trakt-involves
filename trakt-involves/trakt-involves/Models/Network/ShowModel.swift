//
//  ShowModel.swift
//  trakt-involves
//
//  Created by iMac on 27/07/17.
//  Copyright © 2017 Flavio Kruger Bittencourt. All rights reserved.
//

import Foundation
import ObjectMapper

class ShowModel {
    var title: String?
    var year: Int?
    var ids: IdModels?
    var overview: String?
    var network: String?

    required convenience init?(map: Map) {
        self.init()
    }
}

extension ShowModel: Mappable {
    
    func mapping(map: Map) {
        title <- map["title"]
        year <- map["year"]
        ids <- map["ids"]
        overview <- map["overview"]
        network <- map["network"]
    }
}
