//
//  WatchlistInteractor.swift
//  trakt-involves
//
//  Created by iMac on 26/07/17.
//  Copyright © 2017 Flavio Kruger Bittencourt. All rights reserved.
//

import RxSwift

class WatchlistInteractor: WatchlistInteractorInputProtocol {

    weak var interactorOutput: WatchlistInteractorOutputProtocol?
    
    fileprivate var disposeBag = DisposeBag()
    
    func fetchWatchList() {
        ShowAPI.fetchWatchlist()
        .subscribeOn(MainScheduler.instance)
        .map(convertWatchlistModelsToViewData)
        .subscribe(onNext: { viewData in
            self.interactorOutput?.fetchedWatchList(viewData)
        }, onError: { error in
        
        }).addDisposableTo(disposeBag)
    }
}

extension WatchlistInteractor {
    
    fileprivate func convertWatchlistModelsToViewData(searchModels: [WatchlistModel]) -> [WatchlistViewData] {
        return searchModels.map {
            return WatchlistViewData(title: $0.show!.title,
                                     year: $0.show!.year,
                                     traktId: $0.show?.ids?.trakt,
                                     tvdb: $0.show?.ids?.tvdb)
        }
    }
    
}
