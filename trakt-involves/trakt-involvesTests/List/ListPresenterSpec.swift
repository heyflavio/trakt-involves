//
//  ListPresenterSpec.swift
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

@testable import trakt_involves
class ListPresenterSpec: QuickSpec {
    
    private class MockInteractor: ListInteractorInputProtocol {
        
        var fetchStoredDataAssert = false
        var fetchListAssert = false
        var fetchWatchedAssert = false

        fileprivate var interactorOutput: ListInteractorOutputProtocol?
        
        func fetchStoredData(for context: ShowContext) {
            fetchStoredDataAssert = true
        }
        
        func fetchList() {
            fetchListAssert = true
        }
        
        func fetchWatched() {
            fetchWatchedAssert = true
        }
    }
    
    private class MockView: ListPresenterOutputProtocol {
        
        var setListAssert = false
        
        var presenter: ListPresenterInputProtocol?
        
        func setList(_ viewData: [ListViewData]) {
            setListAssert = true
        }
    }
    
    private class MockRouter: ListRouterProtocol {
        
        var presentSearchScreenAssert = false
        var presentSeasonsScreenAssert = false
        
        weak var view: UIViewController?
        
        static func assembleModule(with context: ShowContext) -> UIViewController {
            return UIViewController()
        }
        
        func presentSearchScreen() {
            presentSearchScreenAssert = true
        }
        
        func presentSeasonsScreen(for ListItem: ListViewData) {
            presentSeasonsScreenAssert = true
        }
        
    }
    
    override func spec() {
        
        var presenter: ListPresenter!
        var interactor: MockInteractor!
        var router: MockRouter!
        var view: MockView!
        
        beforeEach {
            presenter = ListPresenter()
            interactor = MockInteractor()
            router = MockRouter()
            view = MockView()
            
            presenter.interactor = interactor
            presenter.presenterOutput = view
            presenter.router = router
        }
        
        describe("the view appearing") {
            context("when the view will present a watchlist context") {
                beforeEach {
                    presenter.context = .watchlist
                    presenter.viewWillAppear()
                }
                it("should tell the interactor to fetch local shows") {
                    expect(interactor.fetchStoredDataAssert).to(beTrue())
                }
                it("should tell the interactor to fetch watchlist shows") {
                    expect(interactor.fetchListAssert).to(beTrue())
                }
            }
            context("when the view will present a watched context") {
                beforeEach {
                    presenter.context = .watched
                    presenter.viewWillAppear()
                }
                it("should tell the interactor to fetch local shows") {
                    expect(interactor.fetchStoredDataAssert).to(beTrue())
                }
                it("should tell the interactor fetch watched shows") {
                    expect(interactor.fetchWatchedAssert).to(beTrue())
                }
            }
        }
        
        describe("the search button being pressed") {
            beforeEach {
                presenter.didPressSearchButton()
            }
            it("should tell the router to present the search screen") {
                expect(router.presentSearchScreenAssert).to(beTrue())
            }
        }
        
        describe("a table view row being pressed") {
            beforeEach {
                presenter.didSelectRow(with: ListViewData(title: "Westworld", year: 2016, traktId: 1234, tvdb: 5678))
            }
            it("should tell the router to present the seasons info screen") {
                expect(router.presentSeasonsScreenAssert).to(beTrue())
            }
        }
        
    }
}
