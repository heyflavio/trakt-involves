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

    
    static func getAllEpisodes(_ show: ShowModel) {
        
    }
    
    static func markAsWatched(_ show: ShowModel) -> Observable<Any>  {
        
        return toggleWatched(true, show: show)
    }
    
    static func unmarkAsWatched(_ show: ShowModel) -> Observable<Any>  {
        
        return toggleWatched(false, show: show)
    }
    
    fileprivate static func toggleWatched(_ watched: Bool, show: ShowModel) -> Observable<Any>  {
        return Observable<Any>.create { observer -> Disposable in
            
            let url = watched ? URL(string: Endpoints.Show.Episode.markAsWatched.url())! : URL(string: Endpoints.Show.Episode.unmarkAsWatched.url())!
            
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
