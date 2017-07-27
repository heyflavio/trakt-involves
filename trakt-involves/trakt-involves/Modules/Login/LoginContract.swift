//
//  LoginContract.swift
//  trakt-involves
//
//  Created by iMac on 26/07/17.
//  Copyright © 2017 Flavio Kruger Bittencourt. All rights reserved.
//

import Foundation
import UIKit

protocol LoginPresenterInputProtocol: class {
    weak var presenterOutput: LoginPresenterOutputProtocol? { get set }
    var router: LoginRouterProtocol? { get set }
    
    func didPressLoginButton()
}

protocol LoginPresenterOutputProtocol: class {
    var presenter: LoginPresenterInputProtocol? { get set }
    
}

protocol LoginRouterProtocol: class {
    weak var view: UIViewController? { get set }
    static func assembleModule() -> UIViewController
    
    func presentAuthenticationScreen()
}
