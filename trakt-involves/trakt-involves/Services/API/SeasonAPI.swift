//
//  SeasonAPI.swift
//  trakt-involves
//
//  Created by iMac on 28/07/17.
//  Copyright © 2017 Flavio Kruger Bittencourt. All rights reserved.
//

import Foundation
import Alamofire
import ObjectMapper
import AlamofireObjectMapper
import AlamofireActivityLogger
import RxSwift
import RxCocoa

struct SeasonAPI {
    
    static func getAllSeasons(for id: Int) -> Observable<[SeasonModel]>   {
        
        return Observable<[SeasonModel]>.create { observer -> Disposable in
            
            let urlRequest = URLRequest.getURLRequest(with: URL(string: Endpoints.Show.Season.getAllSeasons(id).url())!,
                                                      andMethod: .get)
            
            let request = Alamofire
                .request(urlRequest)
                .validate()
                .log()
                .responseArray { (response: DataResponse<[SeasonModel]>) in
                    switch response.result {
                    case .success(let seasons):
                        observer.onNext(seasons)
                        observer.onCompleted()
                    case .failure(let error):
                        observer.onError(error)
                    }
            }
            
            return Disposables.create(with: {
                request.cancel()
            })
        }
    }
}
