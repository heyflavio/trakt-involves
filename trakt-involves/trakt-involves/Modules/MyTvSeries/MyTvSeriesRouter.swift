//
//  MyTvSeriesRouter.swift
//  trakt-involves
//
//  Created by iMac on 26/07/17.
//  Copyright © 2017 Flavio Kruger Bittencourt. All rights reserved.
//

import UIKit

class MyTvSeriesRouter: MyTvSeriesRouterProtocol {
    weak var view: UIViewController?
    
    static func assembleModule() -> UIViewController {
        guard let viewController = R.storyboard.myTvSeries.myTvSeriesViewController() else {
            fatalError()
        }
        
        let presenter = MyTvSeriesPresenter()
        let interactor = MyTvSeriesInteractor()
        let router = MyTvSeriesRouter()
        
        router.view = viewController
        
        viewController.presenter = presenter
        
        presenter.presenterOutput = viewController
        presenter.interactor = interactor
        presenter.router = router
    
        interactor.interactorOutput = presenter

        return viewController
    }
    
}
