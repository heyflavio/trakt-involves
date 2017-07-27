//
//  LoginRouter.swift
//  trakt-involves
//
//  Created by iMac on 26/07/17.
//  Copyright © 2017 Flavio Kruger Bittencourt. All rights reserved.
//

import UIKit
import SafariServices

class LoginRouter: LoginRouterProtocol {
    weak var view: UIViewController?
    
    static func assembleModule() -> UIViewController {
        guard let viewController = R.storyboard.login.loginViewController() else {
            fatalError()
        }
        
        let presenter = LoginPresenter()
        let router = LoginRouter()
        
        router.view = viewController
        
        viewController.presenter = presenter
        
        presenter.presenterOutput = viewController
        presenter.router = router

        return viewController
    }
    
    func presentAuthenticationScreen() {
        let traktAuth = SFSafariViewController(url: URL(string: Endpoints.Authentication.authorize.url(authContext: true))!)
        traktAuth.delegate = view as! LoginViewController
        view?.present(traktAuth, animated: true, completion: nil)
    }
}
