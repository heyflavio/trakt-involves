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
            }, onError: {  error in
                
            }).addDisposableTo(disposeBag)
    }
    
    func fetchShowInfo(for traktId: Int) {
        ShowAPI.showInfo(for: traktId)
            .subscribeOn(MainScheduler.instance)
            .subscribe(onNext: { showModel in
                self.showModel = showModel
                self.interactorOutput?.fetchedShowInfo(self.convertShowModelToViewData(showModel: showModel))
            }, onError: {  error in
                
            }).addDisposableTo(disposeBag)
    }

    func addShowToWatchlist() {
        ShowAPI.addToWatchlist(showModel!)
            .subscribe(onNext: { response in

            }, onError: {  error in
                
            }).addDisposableTo(disposeBag)
    }
    
    func removeShowFromWatchlist() {
        ShowAPI.removeFromWatchlist(showModel!)
            .subscribe(onNext: { response in
                self.showModel?.delete()
            }, onError: {  error in
                
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
            }, onError: {  error in
                
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
        return ShowInfoViewData(title: showModel.title,
                                overview: showModel.overview,
                                year: showModel.year,
                                network: showModel.network,
                                airedEpisodes: showModel.airedEpisodes)
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
