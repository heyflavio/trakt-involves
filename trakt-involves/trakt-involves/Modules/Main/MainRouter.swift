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
        
        let myTvSeriesViewController = MyTvSeriesRouter.assembleModule()
        myTvSeriesViewController.tabBarItem = UITabBarItem(title: "One", image: nil, selectedImage: nil)
        
        let myTvSeriesViewController2 = MyTvSeriesRouter.assembleModule()
        myTvSeriesViewController2.tabBarItem = UITabBarItem(title: "Two", image: nil, selectedImage: nil)
        
        let myTvSeriesViewController3 = MyTvSeriesRouter.assembleModule()
        myTvSeriesViewController3.tabBarItem = UITabBarItem(title: "Three", image: nil, selectedImage: nil)
        
        let myTvSeriesViewController4 = MyTvSeriesRouter.assembleModule()
        myTvSeriesViewController4.tabBarItem = UITabBarItem(title: "Four", image: nil, selectedImage: nil)
        
        let myTvSeriesViewController5 = MyTvSeriesRouter.assembleModule()
        myTvSeriesViewController5.tabBarItem = UITabBarItem(title: "Five", image: nil, selectedImage: nil)
        
        tabBarController.viewControllers = [
            myTvSeriesViewController,
            myTvSeriesViewController2,
            myTvSeriesViewController3,
            myTvSeriesViewController4,
            myTvSeriesViewController5]
        
        return tabBarController
    }
    
}
