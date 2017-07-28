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
    
    func fetchImageUrl(for tvdbId: String?) {
        
        guard let id = tvdbId else {
            return
        }
        
        self.imageUrl(for: id, completion: { url in
            self.interactorOutput?.fetchedImageUrl(url!)
        })
    }
    
    func fetchShowInfo(for traktId: String) {
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
    
}


extension ShowInfoInteractor {
    
    fileprivate func imageUrl(for tvdbId: String, completion: @escaping (String?) -> ()) {
        
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
    
}
