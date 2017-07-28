//
//  ListInteractor.swift
//  trakt-involves
//
//  Created by iMac on 26/07/17.
//  Copyright © 2017 Flavio Kruger Bittencourt. All rights reserved.
//

import RxSwift

class ListInteractor: ListInteractorInputProtocol {
    
    weak var interactorOutput: ListInteractorOutputProtocol?
    
    fileprivate var disposeBag = DisposeBag()
    
    func fetchList() {
        ShowAPI.fetchWatchlist()
            .subscribeOn(MainScheduler.instance)
            .map(convertListModelsToViewData)
            .subscribe(onNext: { viewData in
                self.interactorOutput?.fetchedList(viewData)
            }, onError: { error in
                
            }).addDisposableTo(disposeBag)
    }
    
    func fetchWatched() {
        ShowAPI.fetchWatchedShows()
            .subscribeOn(MainScheduler.instance)
            .map(convertListModelsToViewData)
            .subscribe(onNext: { viewData in
                self.interactorOutput?.fetchedList(viewData)
            }, onError: { error in
                
            }).addDisposableTo(disposeBag)
    }
}

extension ListInteractor {
    
    fileprivate func convertListModelsToViewData(searchModels: [ListModel]) -> [ListViewData] {
        return searchModels.map {
            return ListViewData(title: $0.show!.title,
                                     year: $0.show!.year,
                                     traktId: $0.show?.ids?.trakt,
                                     tvdb: $0.show?.ids?.tvdb)
        }
    }

}
