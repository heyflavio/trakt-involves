//
//  AppDelegate.swift
//  trakt-involves
//
//  Created by iMac on 26/07/17.
//  Copyright © 2017 Flavio Kruger Bittencourt. All rights reserved.
//

import UIKit

@UIApplicationMain
class AppDelegate: UIResponder, UIApplicationDelegate {

    var window: UIWindow?
    var rootPresenter: RootPresenter!
    
    func application(_ application: UIApplication, didFinishLaunchingWithOptions launchOptions: [UIApplicationLaunchOptionsKey: Any]?) -> Bool {

        application.statusBarStyle = .lightContent
        window = UIWindow(frame: UIScreen.main.bounds)
        setupRootModule(in: window)
        
        return true
    }

    func application(_ app: UIApplication, open url: URL, options: [UIApplicationOpenURLOptionsKey : Any]) -> Bool {
        if (url.absoluteString.contains(API.redirectURI)) {
            return AuthenticationManager.getToken(from: url)
        }
        return true
    }

}

extension AppDelegate {

    fileprivate func setupRootModule(in window: UIWindow?) {
        rootPresenter = RootPresenter()
        rootPresenter.router = RootRouter()
        rootPresenter.presentRootScreen(in: window!)
    }
    
    func replaceViewControllerFromRoot(_ newRootViewController: AnyObject, completion: (() -> ())? = nil) {
        if window == nil || window?.subviews == nil || window?.subviews.count == 0 {
            return
        }
        
        let previousViewContoller = window!.rootViewController
        
        UIView.transition(
            with: window!,
            duration: 0.25,
            options: UIViewAnimationOptions.transitionCrossDissolve,
            animations: {
                if newRootViewController is UITabBarController {
                    self.window!.rootViewController = newRootViewController as? UITabBarController
                } else {
                    self.window!.rootViewController = newRootViewController as? UIViewController
                }
                
                self.window?.makeKeyAndVisible()
        }) { finished in
            completion?()
        }
        
        for subview in window!.subviews {
            if subview.isKind(of: NSClassFromString("UITransitionView")!) {
                subview.removeFromSuperview()
            }
        }
        
        previousViewContoller?.dismiss(animated: false, completion: {
            previousViewContoller?.view.removeFromSuperview()
        })
    }
    
}
