//
//  RealmManager.swift
//  trakt-involves
//
//  Created by Flavio Kruger Bittencourt on 30/07/17.
//  Copyright © 2017 Flavio Kruger Bittencourt. All rights reserved.
//

import Foundation
import RealmSwift
import RxRealm

class RealmManager {
    
    static var realm: Realm {
        get {
            return try! Realm()
        }
    }
}

extension RealmManager {
    
    static func saveShow(_ show: ShowModel, context: ShowContext) {
        
        if let _ = RealmManager.getShow(for: show.id) {
            return
        }
        
        let id = show.ids!.trakt
        let show = ShowModel.init(value: show)
        
        show.id = id
        show.context = context
        show.save(with: show.id)
    }
    
    static func getShow(for id: Int) -> ShowModel? {
        return realm.object(ofType: ShowModel.self, forPrimaryKey: id)
    }
    
    static func getShows(for context: ShowContext) -> [ShowModel]? {
        return realm.objects(ShowModel.self).filter("showContext == %i", context.rawValue).toArray()
    }

}

extension RealmManager {
    
    static func saveEpisode(_ episode: EpisodeModel, showId: Int? = nil, watched: Bool? = nil) {
        
        let id = episode.ids!.trakt
        let episode = EpisodeModel.init(value: episode)
        episode.id = id
        
        if let dbEpisode = RealmManager.getEpisode(for: id) {
            episode.watched = watched ?? dbEpisode.watched
            episode.show = dbEpisode.show
        } else {
            episode.show = RealmManager.getShow(for: showId!)
        }
        
        episode.save(with: episode.id)
    }
    
    static func getEpisode(for id: Int) -> EpisodeModel? {
        return realm.object(ofType: EpisodeModel.self, forPrimaryKey: id)
    }
    
    static func markEpisodeAsWatched(_ episode: EpisodeModel) {
        saveEpisode(episode, watched: true)
    }
    
    static func unmarkEpisodeAsWatched(_ episode: EpisodeModel) {
        saveEpisode(episode, watched: false)
    }
    
}
