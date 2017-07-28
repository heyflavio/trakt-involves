//
//  SearchViewData.swift
//  trakt-involves
//
//  Created by iMac on 27/07/17.
//  Copyright © 2017 Flavio Kruger Bittencourt. All rights reserved.
//

import Foundation

struct SearchViewData {
    var title: String
    var year: String
    var tracktId: String
    var tvdb: String
    
    init(title: String = "", year: Int?, traktId: Int, tvdb: Int?) {
        self.title = title
        self.year = year != nil ? "\(year!)" : ""
        self.tracktId = "\(traktId)"
        self.tvdb = tvdb != nil ? "\(tvdb!)" : ""
    }
}
