//
//  SeasonModel.swift
//  trakt-involves
//
//  Created by iMac on 28/07/17.
//  Copyright © 2017 Flavio Kruger Bittencourt. All rights reserved.
//

import Foundation
import ObjectMapper

class SeasonModel {
    var number: Int?
    var ids: IdModels?
    var title: String?
    
    required convenience init?(map: Map) {
        self.init()
    }
}

extension SeasonModel: Mappable {
    
    func mapping(map: Map) {
        number <- map["number"]
        ids <- map["ids"]
        title <- map["title"]
    }
}
