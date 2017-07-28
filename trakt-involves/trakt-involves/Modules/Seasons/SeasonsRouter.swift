//
//  SeasonsRouter.swift
//  trakt-involves
//
//  Created by iMac on 28/07/17.
//  Copyright © 2017 Flavio Kruger Bittencourt. All rights reserved.
//

import UIKit

class SeasonsRouter: SeasonsRouterProtocol {
    weak var view: UIViewController?
    
    static func assembleModule(with watchlistItem: WatchlistViewData) -> UIViewController {
        guard let viewController = R.storyboard.seasons.seasonsViewController() else {
            fatalError()
        }
        
        let presenter = SeasonsPresenter()
        let interactor = SeasonsInteractor()
        let router = SeasonsRouter()
        
        router.view = viewController
        
        viewController.presenter = presenter
        
        presenter.presenterOutput = viewController
        presenter.interactor = interactor
        presenter.router = router
    
        presenter.watchlistItem = watchlistItem
        
        interactor.interactorOutput = presenter

        return viewController
    }
    
    func presentEpisodesScreen(for watchlistItem: WatchlistViewData, and seasonNumber: Int) {
        view?.navigationController?.pushViewController(EpisodesRouter.assembleModule(with: watchlistItem,
                                                                                     and: seasonNumber), animated: true)
    }
    
}
