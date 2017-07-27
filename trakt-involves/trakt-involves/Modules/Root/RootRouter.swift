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
        window.makeKeyAndVisible()
        window.rootViewController = LoginRouter.assembleModule()
    }
    
    func presentMainScreen(in window: UIWindow) {
        window.makeKeyAndVisible()
        window.rootViewController = MainRouter.assembleModule()
    }

}
