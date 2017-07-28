//
//  SearchInteractor.swift
//  trakt-involves
//
//  Created by iMac on 27/07/17.
//  Copyright © 2017 Flavio Kruger Bittencourt. All rights reserved.
//

import UIKit
import RxSwift

class SearchInteractor: SearchInteractorInputProtocol {
    
    weak var interactorOutput: SearchInteractorOutputProtocol?
    
    fileprivate var disposeBag = DisposeBag()
    
    func search(query: String) {
        
        SearchAPI.search(with: query)
            .subscribeOn(ConcurrentDispatchQueueScheduler(queue: DispatchQueue.global(qos: .background)))
            .map(convertSearchModelsToViewData)
            .subscribe(onNext: { searchResults in
                
                self.interactorOutput?.searchedResults(searchResults)
                

            }, onError: {  error in
                
            }).addDisposableTo(disposeBag)
    }
}

extension SearchInteractor {
    
    fileprivate func convertSearchModelsToViewData(searchModels: [SearchModel]) -> [SearchViewData] {
        return searchModels.map {
            return SearchViewData(title: $0.show!.title,
                                  year: $0.show!.year,
                                  traktId: $0.show!.ids!.trakt!,
                                  tvdb: $0.show!.ids!.tvdb)
        }
    }
    
}
