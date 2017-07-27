//
//  RootPresenter.swift
//  trakt-involves
//
//  Created by iMac on 26/07/17.
//  Copyright © 2017 Flavio Kruger Bittencourt. All rights reserved.
//

import Foundation
import UIKit

class RootPresenter: RootPresenterInput {
    
    var router: RootWireframe!
    
    func presentRootScreen(in window: UIWindow) {
        
        if AuthenticationManager.isLoggedIn {
            router.presentMainScreen(in: window)
        } else {
            router.presentLoginScreen(in: window)
        }
    }
}
