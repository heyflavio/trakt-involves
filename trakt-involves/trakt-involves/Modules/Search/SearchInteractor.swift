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
            .map(convertShowModelsToViewData)
            .subscribe(onNext: { searchResults in
                
                self.interactorOutput?.searchedResults(searchResults)
                

            }, onError: {  error in
                
            }).addDisposableTo(disposeBag)
    }
}

extension SearchInteractor {
    
    fileprivate func convertShowModelsToViewData(showModels: [ShowModel]) -> [SearchViewData] {
        return showModels.map {
            return SearchViewData(title: $0.title,
                                  year: $0.year,
                                  traktId: $0.ids!.trakt,
                                  tvdb: $0.ids!.tvdb)
        }
    }
    
}
