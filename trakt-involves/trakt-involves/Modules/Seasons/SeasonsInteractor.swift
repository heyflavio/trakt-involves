//
//  SeasonsInteractor.swift
//  trakt-involves
//
//  Created by iMac on 28/07/17.
//  Copyright © 2017 Flavio Kruger Bittencourt. All rights reserved.
//

import RxSwift

class SeasonsInteractor: SeasonsInteractorInputProtocol {
    
    weak var interactorOutput: SeasonsInteractorOutputProtocol?
    
    fileprivate var disposeBag = DisposeBag()
    
    
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
    
    func fetchAllSeasons(for id: Int) {
        SeasonAPI.getAllSeasons(for: id)
            .observeOn(MainScheduler.instance)
            .map(convertSeasonModelsToViewData)
            .subscribe(onNext: { seasons in
                self.interactorOutput?.fetchedSeasons(seasons)
            }, onError: { error in
                
            }).addDisposableTo(disposeBag)
    }
    
    func fetchNextEpisode(for id: Int) {
        EpisodeAPI.getNextEpisode(for: id)
            .observeOn(MainScheduler.instance)
            .map(convertEpisodeModelToViewData)
            .subscribe(onNext: { episode in
                self.interactorOutput?.fetchedNextEpisode(episode)
            }, onError: { error in
                
            }).addDisposableTo(disposeBag)
    }
    
    func fetchAiredEpisodesCount(for traktId: Int) {
        ShowAPI.showInfo(for: traktId)
            .subscribeOn(MainScheduler.instance)
            .map({ $0.airedEpisodes ?? 0 })
            .subscribe(onNext: { airedEpisodes in
                self.interactorOutput?.fetchedAiredEpisodesCount(airedEpisodes)
            }, onError: {  error in
                
            }).addDisposableTo(disposeBag)
    }
    
    func fetchWatchedEpisodes(for id: Int) {
        EpisodeAPI.getWatchedEpisodes(for: id)
            .observeOn(MainScheduler.instance)
            .map({ $0.count })
            .subscribe(onNext: { watchedEpisodesCount in
                self.interactorOutput?.fetchedWatchedEpisodesCount(watchedEpisodesCount)
            }, onError: { error in
                
            }).addDisposableTo(disposeBag)
    }
}

extension SeasonsInteractor {
    
    fileprivate func convertSeasonModelsToViewData(seasonModels: [SeasonModel]) -> [SeasonViewData] {
        return seasonModels.map {
            return SeasonViewData(title: $0.title,
                                  number: $0.number)
        }
    }
    
    fileprivate func convertEpisodeModelToViewData(episodeModel: EpisodeModel) -> EpisodeViewData {
        return EpisodeViewData(title: episodeModel.title,
                                number: episodeModel.number,
                                season: episodeModel.season,
                                tracktId: episodeModel.ids!.trakt!,
                                tvdb: episodeModel.ids?.tvdb,
                                overview: episodeModel.overview,
                                firstAired: episodeModel.firstAired)
    }
}
