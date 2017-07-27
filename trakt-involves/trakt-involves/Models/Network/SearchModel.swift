//
//  SearchModel.swift
//  trakt-involves
//
//  Created by iMac on 27/07/17.
//  Copyright © 2017 Flavio Kruger Bittencourt. All rights reserved.
//

import Foundation
import ObjectMapper

class SearchModel {
    var score: Double? = 0
    var show: ShowModel?
    
    required convenience init?(map: Map) {
        self.init()
    }
}

extension SearchModel: Mappable {
    
    func mapping(map: Map) {
        score <- map["score"]
        show <- map["show"]
    }
}

