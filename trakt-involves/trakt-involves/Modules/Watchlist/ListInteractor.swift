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
            .map(convertWatchlistShowModelsToViewData)
            .subscribe(onNext: { viewData in
                self.interactorOutput?.fetchedList(viewData)
            }, onError: { error in
                
            }).addDisposableTo(disposeBag)
    }
    
    func fetchWatched() {
        ShowAPI.fetchWatchedShows()
            .subscribeOn(MainScheduler.instance)
            .map(convertWatchedShowModelsToViewData)
            .subscribe(onNext: { viewData in
                self.interactorOutput?.fetchedList(viewData)
            }, onError: { error in
                
            }).addDisposableTo(disposeBag)
    }
}

extension ListInteractor {
    
    fileprivate func convertWatchlistShowModelsToViewData(models: [ShowModel]) -> [ListViewData] {
        return convertShowModelsToViewData(searchModels: models, context: .watchlist)
    }
    
    fileprivate func convertWatchedShowModelsToViewData(models: [ShowModel]) -> [ListViewData] {
        return convertShowModelsToViewData(searchModels: models, context: .watched)
    }

    private func convertShowModelsToViewData(searchModels: [ShowModel], context: ShowContext) -> [ListViewData] {
        return searchModels.map {
            
            RealmManager.saveShow($0, context: context)
            
            return ListViewData(title: $0.title,
                                year: $0.year,
                                traktId: $0.ids?.trakt,
                                tvdb: $0.ids?.tvdb)
        }
    }
}
