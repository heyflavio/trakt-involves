//
//  RealmManager.swift
//  trakt-involves
//
//  Created by Flavio Kruger Bittencourt on 30/07/17.
//  Copyright © 2017 Flavio Kruger Bittencourt. All rights reserved.
//

import Foundation
import RealmSwift

class RealmManager {
    
    static var realm: Realm {
        get {
            return try! Realm()
        }
    }
}

extension RealmManager {
    
    static func saveShow(_ show: ShowModel, context: ShowContext) {
        show.id = show.ids!.trakt
        show.context = context
        show.save(with: show.id)
    }
    
    static func getShow(for id: Int) -> ShowModel? {
        return realm.object(ofType: ShowModel.self, forPrimaryKey: id)
    }
    
    static func saveEpisode(_ episode: EpisodeModel, showId: Int) {
        episode.id = episode.ids!.trakt
        episode.show = RealmManager.getShow(for: showId)
        episode.save(with: episode.id)
    }
    
}
