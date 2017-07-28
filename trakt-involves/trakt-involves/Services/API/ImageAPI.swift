//
//  ImageAPI.swift
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

struct ImageAPI {
    
    static func image(for id: Int) -> Observable<ImageModel>  {
        
        return Observable<ImageModel>.create { observer -> Disposable in
            
            let urlRequest = URLRequest.getImageURLRequest(with: URL(string: Endpoints.Image.get(id).url(imageContext: true))!,
                                                           andMethod: .get)
            
            let request = Alamofire
                .request(urlRequest)
                .validate()
                .log()
                .responseObject { (response: DataResponse<ImageModel>) in
                    switch response.result {
                    case .success(let imageModel):
                        observer.onNext(imageModel)
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
