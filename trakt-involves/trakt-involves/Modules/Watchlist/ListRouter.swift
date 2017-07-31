//
//  ListRouter.swift
//  trakt-involves
//
//  Created by iMac on 26/07/17.
//  Copyright © 2017 Flavio Kruger Bittencourt. All rights reserved.
//

import UIKit

class ListRouter: ListRouterProtocol {
    weak var view: UIViewController?
    
    static func assembleModule(with context: ShowContext) -> UIViewController {
        
        let navigationController = R.storyboard.list.listNavigationController()
        let viewController = navigationController?.visibleViewController as! ListViewController
        
        let presenter = ListPresenter()
        let interactor = ListInteractor()
        let router = ListRouter()
        
        router.view = viewController
        
        viewController.presenter = presenter
        
        presenter.presenterOutput = viewController
        presenter.interactor = interactor
        presenter.router = router
    
        presenter.context = context
        
        interactor.interactorOutput = presenter

        return navigationController!
    }
    
    func presentSearchScreen() {
        view?.present(SearchRouter.assembleModule())
    }
    
    func presentSeasonsScreen(for ListItem: ListViewData) {
        view?.navigationController?.pushViewController(SeasonsRouter.assembleModule(with: ListItem), animated: true)
    }
}
