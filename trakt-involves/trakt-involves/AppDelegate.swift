//
//  AppDelegate.swift
//  trakt-involves
//
//  Created by iMac on 26/07/17.
//  Copyright © 2017 Flavio Kruger Bittencourt. All rights reserved.
//

import UIKit
import RxSwift

@UIApplicationMain
class AppDelegate: UIResponder, UIApplicationDelegate {

    var window: UIWindow?
    var rootPresenter: RootPresenter!

    fileprivate var disposeBag = DisposeBag()
    
    func application(_ application: UIApplication, didFinishLaunchingWithOptions launchOptions: [UIApplicationLaunchOptionsKey: Any]?) -> Bool {
        // Override point for customization after application launch.
        
        window = UIWindow(frame: UIScreen.main.bounds)
        setupRootModule(in: window)
        
        return true
    }

    func application(_ app: UIApplication, open url: URL, options: [UIApplicationOpenURLOptionsKey : Any]) -> Bool {
        if (url.absoluteString.contains(API.redirectURI)) {
            
            guard let urlComponents = URLComponents(url: url, resolvingAgainstBaseURL: true),
                let code = urlComponents.queryItems?.first(where: { $0.name == "code" })?.value else {
                return false
            }
            
            AuthenticationAPI.getToken(from: code)
            .subscribeOn(MainScheduler.instance)
            .subscribe( onNext: { tags in

            }, onError: { error in

            }).addDisposableTo(disposeBag)
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
