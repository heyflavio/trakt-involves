//
//  ShowInfoRouter.swift
//  trakt-involves
//
//  Created by iMac on 27/07/17.
//  Copyright © 2017 Flavio Kruger Bittencourt. All rights reserved.
//

import UIKit

class ShowInfoRouter: ShowInfoRouterProtocol {
    weak var view: UIViewController?
    
    static func assembleModule(with context: InfoContext,
                               traktId: Int,
                               tvdb: Int?,
                               title: String?,
                               seasonNumber: Int? = nil,
                               episodeNumber: Int? = nil) -> UIViewController{
        
        guard let viewController = R.storyboard.showInfo.showInfoViewController() else {
            fatalError()
        }
        
        let presenter = ShowInfoPresenter()
        let interactor = ShowInfoInteractor()
        let router = ShowInfoRouter()
        
        router.view = viewController
        
        viewController.presenter = presenter
        
        presenter.presenterOutput = viewController
        presenter.interactor = interactor
        presenter.router = router
    
        presenter.context = context
        presenter.traktId = traktId
        presenter.title = title
        presenter.tvdb = tvdb
        presenter.seasonNumber = seasonNumber
        presenter.episodeNumber = episodeNumber
        
        interactor.interactorOutput = presenter

        return viewController
    }
    
    func dismissCurrentScreen() {
        view?.navigationController?.popViewController(animated: true)
    }
    
}
