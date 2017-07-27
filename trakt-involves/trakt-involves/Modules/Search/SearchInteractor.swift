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
                
//                var searchResultsViewData = searchResults
//                
//                let myGroup = DispatchGroup()
//                
//                searchResultsViewData.forEach { searchResult in
//                    myGroup.enter()
//                    
//                    self.imageUrl(for: searchResult, completion: { url in
//                        var result = searchResult
//                        result.imageUrl = url
//                        searchResultsViewData.append(result)
// 
//                        myGroup.leave()
//                    })
//                }
//                myGroup.notify(queue: .main) {
//                    
//                }
                
            }, onError: {  error in
                
            }).addDisposableTo(disposeBag)
    }
}


extension SearchInteractor {
    
    fileprivate func imageUrl(for searchViewData: SearchViewData, completion: @escaping (String?) -> ()) {
        
        ImageAPI.image(for: searchViewData.tvdb)
            .subscribeOn(ConcurrentDispatchQueueScheduler(queue: DispatchQueue.global(qos: .background)))
            .subscribe(onNext: { imageResults in
                
                completion(imageResults.clearlogo?[0].url)
            }, onError: {  error in
                
            }).addDisposableTo(disposeBag)
    }
    
    fileprivate func convertSearchModelsToViewData(searchModels: [SearchModel]) -> [SearchViewData] {
        return searchModels.map {
            return SearchViewData(title: $0.show!.title!,
                                  year: $0.show!.year,
                                  tvdb: $0.show!.ids!.tvdb,
                                  imageUrl: nil)
        }
    }
    
}
