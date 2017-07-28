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
    
    static func assembleModule(with traktId: Int) -> UIViewController {
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
    
        presenter.traktId = traktId
        
        interactor.interactorOutput = presenter

        return viewController
    }
    
    
    func presentEpisodesScreen(for traktId: Int, and seasonNumber: Int){
        view?.navigationController?.pushViewController(EpisodesRouter.assembleModule(with: traktId, and: seasonNumber), animated: true)
    }
    
}
