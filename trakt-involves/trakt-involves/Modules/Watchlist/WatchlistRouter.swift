//
//  WatchlistRouter.swift
//  trakt-involves
//
//  Created by iMac on 26/07/17.
//  Copyright © 2017 Flavio Kruger Bittencourt. All rights reserved.
//

import UIKit

class WatchlistRouter: WatchlistRouterProtocol {
    weak var view: UIViewController?
    
    static func assembleModule() -> UIViewController {
        
        let navigationController = R.storyboard.watchlist.watchlistNavigationController()
        let viewController = navigationController?.visibleViewController as! WatchlistViewController
        
        let presenter = WatchlistPresenter()
        let interactor = WatchlistInteractor()
        let router = WatchlistRouter()
        
        router.view = viewController
        
        viewController.presenter = presenter
        
        presenter.presenterOutput = viewController
        presenter.interactor = interactor
        presenter.router = router
    
        interactor.interactorOutput = presenter

        return navigationController!
    }
    
    func presentSearchScreen() {
        view?.present(SearchRouter.assembleModule())
    }
    
    func presentSeasonsScreen(for watchListItem: WatchlistViewData) {
        view?.navigationController?.pushViewController(SeasonsRouter.assembleModule(with: watchListItem), animated: true)
    }
}
