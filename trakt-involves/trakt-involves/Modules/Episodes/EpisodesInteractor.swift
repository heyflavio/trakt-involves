//
//  EpisodesInteractor.swift
//  trakt-involves
//
//  Created by iMac on 28/07/17.
//  Copyright © 2017 Flavio Kruger Bittencourt. All rights reserved.
//

import RxSwift

class EpisodesInteractor: EpisodesInteractorInputProtocol {
    
    weak var interactorOutput: EpisodesInteractorOutputProtocol?
    
    fileprivate var disposeBag = DisposeBag()
    
    func fetchAllEpisodes(for id: Int, and seasonNumber: Int) {
        EpisodeAPI.getAllEpisodes(for: id, and: seasonNumber)
            .observeOn(MainScheduler.instance)
            .map(convertEpisodeModelsToViewData)
            .subscribe(onNext: { episodes in
                self.interactorOutput?.fetchedEpisodes(episodes)
            }, onError: { error in
                
            }).addDisposableTo(disposeBag)
    }
}

extension EpisodesInteractor {
    
    fileprivate func convertEpisodeModelsToViewData(episodeModels: [EpisodeModel]) -> [EpisodeViewData] {
        return episodeModels.map {
            return EpisodeViewData(title: $0.title!,
                                  number: $0.number)
        }
    }
    
}
