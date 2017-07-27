//
//  AuthenticationAPI.swift
//  trakt-involves
//
//  Created by iMac on 26/07/17.
//  Copyright © 2017 Flavio Kruger Bittencourt. All rights reserved.
//

import Foundation
import Alamofire
import ObjectMapper
import AlamofireObjectMapper
import AlamofireActivityLogger
import RxSwift
import RxCocoa

class AuthenticationAPI {
    
    static func getToken(from code: String) -> Observable<Any>  {
        
        return Observable.create { observer -> Disposable in
            
            let body = ["code": code,
                        "client_id": API.clientId,
                        "client_secret": API.clientSecret,
                        "redirect_uri": API.redirectURI,
                        "grant_type": "authorization_code"]
            
            let urlRequest = URLRequest.getURLRequest(with: URL(string: Endpoints.Authentication.getToken.url())!,
                                                      body: body,
                                                      andMethod: .post)
            
            let request = Alamofire
                .request(urlRequest)
                .validate()
                .log()
                .responseJSON { response in
                    switch response.result {
                    case .success:
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
