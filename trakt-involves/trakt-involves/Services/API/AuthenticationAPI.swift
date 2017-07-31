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

struct AuthenticationAPI {
    
    static func getToken(from code: String) -> Observable<AuthenticationModel>  {
        
        let body = ["code": code,
                    "client_id": API.clientId,
                    "client_secret": API.clientSecret,
                    "redirect_uri": API.redirectURI,
                    "grant_type": "authorization_code"]
        
        let urlRequest = URLRequest.getURLRequest(with: URL(string: Endpoints.Authentication.getToken.url())!,
                                                  body: body,
                                                  andMethod: .post)
        
        return requestToken(for: urlRequest)
    }
    
    static func refreshToken(_ token: String) -> Observable<AuthenticationModel>  {
        
        let body = ["refresh_token": token,
                    "client_id": API.clientId,
                    "client_secret": API.clientSecret,
                    "redirect_uri": API.redirectURI,
                    "grant_type": "refresh_token"]
        
        let urlRequest = URLRequest.getURLRequest(with: URL(string: Endpoints.Authentication.getToken.url())!,
                                                  body: body,
                                                  andMethod: .post)
        
        return requestToken(for: urlRequest)
    }
    
    private static func requestToken(for urlRequest: URLRequest)  -> Observable<AuthenticationModel> {
        return Observable<AuthenticationModel>.create { observer -> Disposable in
            
            let request = Alamofire
                .request(urlRequest)
                .validate()
                .log()
                .responseObject { (response: DataResponse<AuthenticationModel>) in
                    switch response.result {
                    case .success(let authentication):
                        observer.onNext(authentication)
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
