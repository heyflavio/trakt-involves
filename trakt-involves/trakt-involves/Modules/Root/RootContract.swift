//
//  RootContract.swift
//  trakt-involves
//
//  Created by iMac on 26/07/17.
//  Copyright © 2017 Flavio Kruger Bittencourt. All rights reserved.
//

import Foundation
import UIKit

protocol RootPresenterInput: class {
    func presentRootScreen(in window: UIWindow)
}

protocol RootWireframe: class {
    func presentLoginScreen(in window: UIWindow)
    func presentMainScreen(in window: UIWindow)
}
