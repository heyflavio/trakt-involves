//
//  HomeRouter.swift
//  trakt-involves
//
//  Created by iMac on 26/07/17.
//  Copyright © 2017 Flavio Kruger Bittencourt. All rights reserved.
//

import UIKit

class MainRouter: MainRouterProtocol {
    weak var view: UIViewController?
    
    static func assembleModule() -> UIViewController {
        let tabBarController = MainTabBarController()
        let router = MainRouter()
        let presenter = MainPresenter(router: router)
        let interactor = MainInteractor()
        
        tabBarController.presenter = presenter
        router.view = tabBarController
        
        presenter.presenterOutput = tabBarController
        presenter.interactor = interactor
        presenter.router = router
        
        interactor.interactorOutput = presenter
        
        let watchlistViewController = ListRouter.assembleModule(with: .watchlist)
        watchlistViewController.tabBarItem = UITabBarItem(title: R.string.strings.watchlist(), image: #imageLiteral(resourceName: "watchlistIcon"), selectedImage: nil)
        
        let watchedViewController = ListRouter.assembleModule(with: .watched)
        watchedViewController.tabBarItem = UITabBarItem(title: R.string.strings.watching(), image: #imageLiteral(resourceName: "watchingIcon"), selectedImage: nil)
        
        tabBarController.viewControllers = [
            watchlistViewController,
            watchedViewController]
        
        return tabBarController
    }
    
}
