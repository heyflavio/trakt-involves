//
//  EpisodeViewData.swift
//  trakt-involves
//
//  Created by iMac on 28/07/17.
//  Copyright © 2017 Flavio Kruger Bittencourt. All rights reserved.
//

import Foundation

struct EpisodeViewData {
    var title: String
    var number: Int?
    var season: Int?
    var tracktId: Int?
    var tvdb: Int?
    var overview: String?
    var firstAired: String
    
    init(title: String?, number: Int?, season: Int?, tracktId: Int, tvdb: Int?, overview: String?, firstAired: Date?) {
        self.title = title ?? "There's no next episodes"
        self.number = number
        self.season = season
        self.tracktId = tracktId
        self.tvdb = tvdb
        self.overview = overview
        self.firstAired = firstAired?.formatted() ?? "Date unknown"
    }
}
