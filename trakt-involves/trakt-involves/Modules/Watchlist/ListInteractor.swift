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
        
        self.interactorOutput?.fetchedList(RealmManager.getShows(for: .watchlist).map(convertWatchlistShowModelsToViewData)!)
        
        ShowAPI.fetchWatchlist()
            .subscribeOn(MainScheduler.instance)
            .map(convertWatchlistShowModelsToViewData)
            .subscribe(onNext: { viewData in
                self.interactorOutput?.fetchedList(viewData)
            }, onError: { error in
                
            }).addDisposableTo(disposeBag)
    }
    
    func fetchWatched() {
        
        self.interactorOutput?.fetchedList(RealmManager.getShows(for: .watched).map(convertWatchlistShowModelsToViewData)!)
        
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
        return convertShowModelsToViewData(showModels: models, context: .watchlist)
    }
    
    fileprivate func convertWatchedShowModelsToViewData(models: [ShowModel]) -> [ListViewData] {
        return convertShowModelsToViewData(showModels: models, context: .watched)
    }

    private func convertShowModelsToViewData(showModels: [ShowModel], context: ShowContext) -> [ListViewData] {
        return showModels.map {
            
            RealmManager.saveShow($0, context: context)
            
            return ListViewData(title: $0.title,
                                year: $0.year,
                                traktId: $0.ids?.trakt ?? $0.id,
                                tvdb: $0.ids?.tvdb)
        }
    }
}
