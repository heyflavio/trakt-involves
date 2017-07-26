//
//  ViewProtocols.swift
//  trakt-involves
//
//  Created by iMac on 26/07/17.
//  Copyright © 2017 Flavio Kruger Bittencourt. All rights reserved.
//

import Foundation
import PKHUD

protocol ShowSuccess: class {
    func showSuccess(_ success: String)
}

protocol ErrorHandler: class {
    func handleError(_ error: Error)
}

protocol ShowError: class {
    func showError(_ error: String)
    func showNetworkError()
}

protocol ActivityIndicator: class {
    func showActivityIndicator()
    func stopActivityIndicator()
}

extension ShowError where Self: UIViewController {
    
    func showError(_ error: String) {

    }
    
    func showNetworkError() {

    }
}

extension ShowSuccess where Self: UIViewController {
    
    func showSuccess(_ success: String) {

    }
}

extension ActivityIndicator where Self: UIViewController {
    
    func showActivityIndicator() {
        HUD.dimsBackground = false
        HUD.show(.systemActivity, onView: UIApplication.topViewController()?.view.superview != nil ? UIApplication.topViewController()?.view.superview : UIApplication.topViewController()?.view)
    }
    
    func stopActivityIndicator() {
        HUD.hide()
    }
}
