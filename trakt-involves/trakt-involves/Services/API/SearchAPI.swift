//
//  SearchAPI.swift
//  trakt-involves
//
//  Created by iMac on 27/07/17.
//  Copyright © 2017 Flavio Kruger Bittencourt. All rights reserved.
//

import Foundation
import Alamofire
import ObjectMapper
import AlamofireObjectMapper
import AlamofireActivityLogger
import RxSwift
import RxCocoa

struct SearchAPI {
    
    static func search(with query: String) -> Observable<[ShowModel]>  {
        
        return Observable<[ShowModel]>.create { observer -> Disposable in
            
            let urlRequest = URLRequest.getURLRequest(with: URL(string: Endpoints.Search.query(query.replacingOccurrences(of: " ", with: "%20")).url())!,
                                                      andMethod: .get)
            
            let request = Alamofire
                .request(urlRequest)
                .validate()
                .log()
                .responseArray(keyPath: "show") { (response: DataResponse<[ShowModel]>) in
                    switch response.result {
                    case .success(let searchResponse):
                        observer.onNext(searchResponse)
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
