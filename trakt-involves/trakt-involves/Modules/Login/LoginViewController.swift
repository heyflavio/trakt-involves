//
//  LoginViewController.swift
//  trakt-involves
//
//  Created by iMac on 26/07/17.
//  Copyright © 2017 Flavio Kruger Bittencourt. All rights reserved.
//

import UIKit
import SafariServices

class LoginViewController: UIViewController {
    
    var presenter: LoginPresenterInputProtocol?
    
    @IBAction func didPressLoginButton(_ sender: UIButton) {
        presenter?.didPressLoginButton()
    }

}

extension LoginViewController: SFSafariViewControllerDelegate {
    
}
