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
        
        self.imageUrl(for: id, completion: { url in
            self.interactorOutput?.fetchedImageUrl(url!)
        })
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
                
            }, onError: {  error in
                
            }).addDisposableTo(disposeBag)
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
            .subscribe(onNext: { response in
                
            }).addDisposableTo(disposeBag)
    }
    
    func unmarkEpisodeAsWatched() {
        EpisodeAPI.unmarkAsWatched(episodeModel!)
            .subscribe(onNext: { response in
                
            }).addDisposableTo(disposeBag)
    }
}


extension ShowInfoInteractor {
    
    fileprivate func imageUrl(for tvdbId: Int, completion: @escaping (String?) -> ()) {
        
        ImageAPI.image(for: tvdbId)
            .subscribeOn(ConcurrentDispatchQueueScheduler(queue: DispatchQueue.global(qos: .background)))
            .subscribe(onNext: { imageResults in
                
                completion(imageResults.clearlogo?[0].url)
            }, onError: {  error in
                
            }).addDisposableTo(disposeBag)
    }
    
    fileprivate func convertShowModelToViewData(showModel: ShowModel) -> ShowInfoViewData {
        return ShowInfoViewData(title: showModel.title,
                                overview: showModel.overview,
                                year: showModel.year,
                                network: showModel.network)
    }
    
    fileprivate func convertEpisodeModelToViewData(episodeModel: EpisodeModel) -> EpisodeViewData {
        return EpisodeViewData(title: episodeModel.title,
                               number: episodeModel.number,
                               season: episodeModel.season,
                               tracktId: episodeModel.ids!.trakt!,
                               tvdb: episodeModel.ids?.tvdb,
                               overview: episodeModel.overview)
    }
    
}
