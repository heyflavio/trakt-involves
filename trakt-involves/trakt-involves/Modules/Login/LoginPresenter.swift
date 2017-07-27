//
//  LoginPresenter.swift
//  trakt-involves
//
//  Created by iMac on 26/07/17.
//  Copyright © 2017 Flavio Kruger Bittencourt. All rights reserved.
//

class LoginPresenter: LoginPresenterInputProtocol {

    weak var presenterOutput: LoginPresenterOutputProtocol?
    var router: LoginRouterProtocol?
    
    func didPressLoginButton() {
        router?.presentAuthenticationScreen()
    }
    
}
