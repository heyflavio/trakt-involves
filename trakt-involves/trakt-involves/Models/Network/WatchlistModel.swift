//
//  WatchlistModel.swift
//  trakt-involves
//
//  Created by iMac on 28/07/17.
//  Copyright © 2017 Flavio Kruger Bittencourt. All rights reserved.
//

import Foundation
import ObjectMapper

class WatchlistModel {
    var show: ShowModel?
    
    required convenience init?(map: Map) {
        self.init()
    }
}

extension WatchlistModel: Mappable {
    
    func mapping(map: Map) {
        show <- map["show"]
    }
}
