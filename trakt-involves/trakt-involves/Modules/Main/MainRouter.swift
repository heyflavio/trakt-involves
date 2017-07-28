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
        
        let myTvSeriesViewController = ListRouter.assembleModule(with: .watchlist)
        myTvSeriesViewController.tabBarItem = UITabBarItem(title: "Watchlist", image: nil, selectedImage: nil)
        
        let myTvSeriesViewController2 = ListRouter.assembleModule(with: .watched)
        myTvSeriesViewController2.tabBarItem = UITabBarItem(title: "Watching", image: nil, selectedImage: nil)
        
        tabBarController.viewControllers = [
            myTvSeriesViewController,
            myTvSeriesViewController2]
        
        return tabBarController
    }
    
}
