//
//  SearchViewData.swift
//  trakt-involves
//
//  Created by iMac on 27/07/17.
//  Copyright © 2017 Flavio Kruger Bittencourt. All rights reserved.
//

import Foundation

struct SearchViewData {
    var title: String?
    var year: String?
    var tracktId: Int
    var tvdb: Int?
    
    init(title: String? = "", year: Int?, traktId: Int, tvdb: Int?) {
        self.title = title
        self.year = year != nil ? String(year!) : ""
        self.tracktId = traktId
        self.tvdb = tvdb
    }
}
