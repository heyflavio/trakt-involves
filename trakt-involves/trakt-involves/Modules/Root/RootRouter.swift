//
//  RootRouter.swift
//  trakt-involves
//
//  Created by iMac on 26/07/17.
//  Copyright © 2017 Flavio Kruger Bittencourt. All rights reserved.
//

import Foundation
import UIKit

class RootRouter: RootWireframe {
    
    func presentLoginScreen(in window: UIWindow) {
        //    let viewController = R.storyboard.tutorial.tutorialViewController()
        //    let presenter = TutorialPresenter()
        //    let router = TutorialRouter()
        //
        //    router.view = viewController
        //    viewController?.presenter = presenter
        //    presenter.output = viewController
        //    presenter.router = router
        //    window.makeKeyAndVisible()
        //    window.rootViewController = viewController
    }
    
    func presentMainScreen(in window: UIWindow) {
        window.makeKeyAndVisible()
        window.rootViewController = MainRouter.assembleModule()
    }

}
