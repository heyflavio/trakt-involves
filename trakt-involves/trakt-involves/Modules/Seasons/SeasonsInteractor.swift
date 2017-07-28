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
    
    func fetchAllSeasons(for id: Int) {
        SeasonAPI.getAllSeasons(for: id)
            .observeOn(MainScheduler.instance)
            .map(convertSeasonModelsToViewData)
            .subscribe(onNext: { seasons in
                self.interactorOutput?.fetchedSeasons(seasons)
            }, onError: { error in
                
            }).addDisposableTo(disposeBag)
    }
}

extension SeasonsInteractor {
    
    fileprivate func convertSeasonModelsToViewData(seasonModels: [SeasonModel]) -> [SeasonViewData] {
        return seasonModels.map {
            return SeasonViewData(title: $0.title!,
                                  number: $0.number)
        }
    }
    
}
