//
//  EpisodeAPI.swift
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

struct EpisodeAPI {

    static func getAllEpisodes(for id: Int, and seasonNumber: Int) -> Observable<[EpisodeModel]>   {
        
        return Observable<[EpisodeModel]>.create { observer -> Disposable in
            
            let urlRequest = URLRequest.getURLRequest(with: URL(string: Endpoints.Show.Season.Episode.getAllEpisodes(id, seasonNumber).url())!,
                                                      andMethod: .get)
            
            let request = Alamofire
                .request(urlRequest)
                .validate()
                .log()
                .responseArray { (response: DataResponse<[EpisodeModel]>) in
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
    
    static func getNextEpisode(for id: Int) -> Observable<EpisodeModel>   {
        
        return Observable<EpisodeModel>.create { observer -> Disposable in
            
            let urlRequest = URLRequest.getURLRequest(with: URL(string: Endpoints.Show.Season.Episode.getNextEpisode(id).url())!,
                                                      andMethod: .get)
            
            let request = Alamofire
                .request(urlRequest)
                .validate()
                .log()
                .responseObject { (response: DataResponse<EpisodeModel>) in
                    switch response.result {
                    case .success(let episode):
                        observer.onNext(episode)
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
    
    static func markAsWatched(_ show: ShowModel) -> Observable<Any>  {
        
        return toggleWatched(true, show: show)
    }
    
    static func unmarkAsWatched(_ show: ShowModel) -> Observable<Any>  {
        
        return toggleWatched(false, show: show)
    }
    
    fileprivate static func toggleWatched(_ watched: Bool, show: ShowModel) -> Observable<Any>  {
        return Observable<Any>.create { observer -> Disposable in
            
            let url = watched ? URL(string: Endpoints.Show.Season.Episode.markAsWatched.url())! : URL(string: Endpoints.Show.Season.Episode.unmarkAsWatched.url())!
            
            let urlRequest = URLRequest.getURLRequest(with: url,
                                                      body: ["episodes": [show.toJSON()]],
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
