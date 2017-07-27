//
//  SearchViewData.swift
//  trakt-involves
//
//  Created by iMac on 27/07/17.
//  Copyright © 2017 Flavio Kruger Bittencourt. All rights reserved.
//

import Foundation
import UIKit

struct SearchViewData {
    var title: String
    var year: String
    var tvdb: String
    var imageUrl: String?
    
    init(title: String = "", year: Int?, tvdb: Int?, imageUrl: String?) {
        self.title = title
        self.year = year != nil ? "\(year!)" : ""
        self.tvdb = tvdb != nil ? "\(tvdb!)" : ""
        self.imageUrl = imageUrl
    }
}
