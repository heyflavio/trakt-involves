//
//  ShowAPI.swift
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

struct ShowAPI {
    
    static func showInfo(for id: Int) -> Observable<ShowModel>  {
        
        return Observable<ShowModel>.create { observer -> Disposable in
            
            let urlRequest = URLRequest.getURLRequest(with: URL(string: Endpoints.Show.get(id).url())!,
                                                      andMethod: .get)
            
            let request = Alamofire
                .request(urlRequest)
                .validate()
                .log()
                .responseObject { (response: DataResponse<ShowModel>) in
                    switch response.result {
                    case .success(let showInfo):
                        observer.onNext(showInfo)
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
    
    static func addToWatchlist(_ show: ShowModel) -> Observable<Any>  {
        
        return Observable<Any>.create { observer -> Disposable in
            
            let urlRequest = URLRequest.getURLRequest(with: URL(string: Endpoints.Show.addToWatchlist.url())!,
                                                      body: ["shows": [show.toJSON()]],
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
    
    static func removeFromWatchlist(_ show: ShowModel) -> Observable<Any>  {
        
        return Observable<Any>.create { observer -> Disposable in
            
            let urlRequest = URLRequest.getURLRequest(with: URL(string: Endpoints.Show.removeFromWatchlist.url())!,
                                                      body: ["shows": [show.toJSON()]],
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
    
    static func fetchWatchlist() -> Observable<[ListModel]>  {
        
        return Observable<[ListModel]>.create { observer -> Disposable in
            
            let urlRequest = URLRequest.getURLRequest(with: URL(string: Endpoints.Show.getWatchlist.url())!,
                                                      andMethod: .get)
            
            let request = Alamofire
                .request(urlRequest)
                .validate()
                .log()
                .responseArray { (response: DataResponse<[ListModel]>) in
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
    
    static func fetchWatchedShows() -> Observable<[ListModel]>   {
        
        return Observable<[ListModel]>.create { observer -> Disposable in
            
            let urlRequest = URLRequest.getURLRequest(with: URL(string: Endpoints.Show.getWatched.url())!,
                                                      andMethod: .get)
            
            let request = Alamofire
                .request(urlRequest)
                .validate()
                .log()
                .responseArray { (response: DataResponse<[ListModel]>) in
                    switch response.result {
                    case .success(let episodes):
                        observer.onNext(episodes)
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
