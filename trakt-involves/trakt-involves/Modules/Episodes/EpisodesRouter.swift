//
//  EpisodesRouter.swift
//  trakt-involves
//
//  Created by iMac on 28/07/17.
//  Copyright © 2017 Flavio Kruger Bittencourt. All rights reserved.
//

import UIKit

class EpisodesRouter: EpisodesRouterProtocol {
    weak var view: UIViewController?
    
    static func assembleModule(with traktId: Int) -> UIViewController {
        guard let viewController = R.storyboard.episodes.episodesViewController() else {
            fatalError()
        }
        
        let presenter = EpisodesPresenter()
        let interactor = EpisodesInteractor()
        let router = EpisodesRouter()
        
        router.view = viewController
        
        viewController.presenter = presenter
        
        presenter.presenterOutput = viewController
        presenter.interactor = interactor
        presenter.router = router
    
        interactor.interactorOutput = presenter

        return viewController
    }
    
}
