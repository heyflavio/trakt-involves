//
//  ListInteractorSpec.swift
//  trakt-involves
//
//  Created by iMac on 31/07/17.
//  Copyright © 2017 Flavio Kruger Bittencourt. All rights reserved.
//
//  Expected outcomes info: https://github.com/Quick/Nimble
//  Quick use info: https://github.com/Quick/Quick/blob/master/Documentation/en-us/QuickExamplesAndGroups.md
//

import Foundation
import Quick
import Nimble
import OHHTTPStubs

@testable import trakt_involves
class ListInteractorSpec: QuickSpec {
    
    private class MockPresenter: ListInteractorOutputProtocol {
        
        var fetchedListAssert = false
        
        fileprivate var interactor: ListInteractorInputProtocol?
        
        func fetchedList(_ viewData: [ListViewData]) {
            fetchedListAssert = true
        }
    }
    
    override func spec() {
        
        var presenter: MockPresenter!
        var interactor: ListInteractor!
        
        beforeEach {
            presenter = MockPresenter()
            interactor = ListInteractor()
            
            presenter.interactor = interactor
            interactor.interactorOutput = presenter
        }
        
        let jsonResponse = ["listed_at": "2014-09-01T09:10:11.000Z",
                            "type": "movie",
                            "movie": ["title": "TRON: Legacy",
                                      "year": 2010,
                                      "ids": ["trakt": 1,
                                              "slug": "tron-legacy-2010",
                                              "imdb": "tt1104001",
                                              "tmdb": 20526] ] ] as [String : Any]
        
        describe("the response for fetching watchlist shows") {
            
            let stubCondition = isMethodGET() && isPath(Endpoints.Show.getWatchlist.pathDropLastSlash)

            beforeEach {
                stub(condition: stubCondition) { _ in
                    
                    return OHHTTPStubsResponse(
                        jsonObject: jsonResponse,
                        statusCode: 200,
                        headers: [ "Content-Type": "application/json" ]
                    )
                }
                interactor?.fetchList()

            }
            it("notify the presenter about the operation success") {
                expect(presenter.fetchedListAssert).toEventually(beTrue(), timeout: 5)
            }
            
        }
        
        describe("the response for fetching watched shows") {
            
            let stubCondition = isMethodGET() && isPath(Endpoints.Show.getWatched.pathDropLastSlash)
            
            beforeEach {
                stub(condition: stubCondition) { _ in
                    
                    return OHHTTPStubsResponse(
                        jsonObject: jsonResponse,
                        statusCode: 200,
                        headers: [ "Content-Type": "application/json" ]
                    )
                }
                
                interactor?.fetchWatched()
            }
            it("notify the presenter about the operation success") {
                expect(presenter.fetchedListAssert).toEventually(beTrue(), timeout: 5)
            }
        }
    }
    
}
