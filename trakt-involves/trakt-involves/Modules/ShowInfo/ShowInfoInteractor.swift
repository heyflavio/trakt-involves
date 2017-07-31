//
//  ShowInfoInteractor.swift
//  trakt-involves
//
//  Created by iMac on 27/07/17.
//  Copyright © 2017 Flavio Kruger Bittencourt. All rights reserved.
//

import RxSwift

class ShowInfoInteractor: ShowInfoInteractorInputProtocol {
    
    weak var interactorOutput: ShowInfoInteractorOutputProtocol?
    
    fileprivate var disposeBag = DisposeBag()
    
    fileprivate var showModel: ShowModel?
    fileprivate var episodeModel: EpisodeModel?
    
    func fetchImageUrl(for tvdbId: Int?) {
        
        guard let id = tvdbId else {
            return
        }
        
        ImageAPI.image(for: id)
            .subscribeOn(ConcurrentDispatchQueueScheduler(queue: DispatchQueue.global(qos: .background)))
            .subscribe(onNext: { imageResults in
                
                self.interactorOutput?.fetchedImageUrl((imageResults.clearlogo![0].url!))
            }).addDisposableTo(disposeBag)
    }
    
    func fetchShowInfo(for traktId: Int) {
        ShowAPI.showInfo(for: traktId)
            .subscribeOn(MainScheduler.instance)
            .subscribe(onNext: { showModel in
                self.showModel = showModel
                self.interactorOutput?.fetchedShowInfo(self.convertShowModelToViewData(showModel: showModel))
            }).addDisposableTo(disposeBag)
    }

    func addShowToWatchlist() {
        if let _ = RealmManager.getShow(for: showModel!.id) {
            return
        }
        
        ShowAPI.addToWatchlist(showModel!)
            .subscribe(onCompleted: {
                self.interactorOutput?.addedShowToWatchlist()
            }).addDisposableTo(disposeBag)
    }
    
    func removeShowFromWatchlist() {
        ShowAPI.removeFromWatchlist(showModel!)
            .subscribe(onNext: { response in
                self.showModel?.delete()
            }).addDisposableTo(disposeBag)
    }
    
    func fetchWatchedState(for id: Int) {
        let episode = RealmManager.getEpisode(for: id)
        if let watched = episode?.watched {
            interactorOutput?.fetchedWatchedState(watched)
        }
    }
    func fetchEpisodeInfo(for traktId: Int, seasonNumber: Int, episodeNumber: Int) {
        EpisodeAPI.getEpisode(for: traktId, seasonNumber: seasonNumber, and: episodeNumber)
            .subscribeOn(MainScheduler.instance)
            .subscribe(onNext: { episodeModel in
                self.episodeModel = episodeModel
                self.interactorOutput?.fetchedEpisodeInfo(self.convertEpisodeModelToViewData(episodeModel: episodeModel))
            }).addDisposableTo(disposeBag)
    }
    
    func markEpisodeAsWatched() {
        EpisodeAPI.markAsWatched(episodeModel!)
            .subscribe(onCompleted: {
                RealmManager.markEpisodeAsWatched(self.episodeModel!)
                self.interactorOutput?.markedEpisodeAsWatched()
            }).addDisposableTo(disposeBag)
    }
    
    func unmarkEpisodeAsWatched() {
        EpisodeAPI.unmarkAsWatched(episodeModel!)
            .subscribe(onCompleted: { 
                RealmManager.unmarkEpisodeAsWatched(self.episodeModel!)
                self.interactorOutput?.unmarkedEpisodeAsWatched()
            }).addDisposableTo(disposeBag)
    }
}


extension ShowInfoInteractor {
    
    fileprivate func convertShowModelToViewData(showModel: ShowModel) -> ShowInfoViewData {

        var watchingState = R.string.strings.addToWatchlist()
        var watchingEnabled = true
        if let dbShow = RealmManager.getShow(for: showModel.ids!.trakt) {
            watchingEnabled = false
            if dbShow.context == .watched {
                watchingState = R.string.strings.alreadyBeingWatched()
            } else {
                watchingState = R.string.strings.alreadyInWatchlist()
            }
        }
        
        return ShowInfoViewData(title: showModel.title,
                                overview: showModel.overview,
                                year: showModel.year,
                                network: showModel.network,
                                airedEpisodes: showModel.airedEpisodes,
                                watchingState: watchingState,
                                watchingEnabled: watchingEnabled)
    }
    
    fileprivate func convertEpisodeModelToViewData(episodeModel: EpisodeModel) -> EpisodeViewData {
        return EpisodeViewData(title: episodeModel.title,
                               number: episodeModel.number,
                               season: episodeModel.season,
                               tracktId: episodeModel.ids!.trakt,
                               tvdb: episodeModel.ids?.tvdb,
                               overview: episodeModel.overview,
                               firstAired: episodeModel.firstAired)
    }
    
}
