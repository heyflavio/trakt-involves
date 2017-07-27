//
//  SearchRouter.swift
//  trakt-involves
//
//  Created by iMac on 27/07/17.
//  Copyright © 2017 Flavio Kruger Bittencourt. All rights reserved.
//

import UIKit

class SearchRouter: SearchRouterProtocol {
    weak var view: UIViewController?
    
    static func assembleModule() -> UIViewController {
        let navigationController = R.storyboard.search.searchNavigationController()
        let viewController = navigationController?.visibleViewController as! SearchViewController
        
        navigationController?.modalTransitionStyle = .crossDissolve
        
        let presenter = SearchPresenter()
        let interactor = SearchInteractor()
        let router = SearchRouter()
        
        router.view = viewController
        
        viewController.presenter = presenter
        
        presenter.presenterOutput = viewController
        presenter.interactor = interactor
        presenter.router = router
    
        interactor.interactorOutput = presenter

        return navigationController!
    }
    
    func presentShowInfoScreen() {
        view?.navigationController?.pushViewController(ShowInfoRouter.assembleModule(), animated: true)
    }
    
    func dismissCurrentScreen() {
        view?.dismiss(animated: true, completion: nil)
    }
}
