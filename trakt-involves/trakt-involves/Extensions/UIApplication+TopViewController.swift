//
//  UIApplication+TopViewController.swift
//  trakt-involves
//
//  Created by iMac on 26/07/17.
//  Copyright © 2017 Flavio Kruger Bittencourt. All rights reserved.
//

import Foundation
import UIKit

extension UIApplication {
    
    class func topViewController(controller: UIViewController? = UIApplication.shared.keyWindow?.rootViewController,
                                 includingSupportingControllers: Bool? = false) -> UIViewController? {
        
        if let navigationController = controller as? UINavigationController {
            return includingSupportingControllers! ? navigationController : topViewController(controller: navigationController.visibleViewController)
        }
        if let tabController = controller as? UITabBarController, let selected = tabController.selectedViewController {
            return includingSupportingControllers! ? tabController : topViewController(controller: selected)
        }
        if let presented = controller?.presentedViewController {
            return topViewController(controller: presented)
        }
        return controller
    }
    
    class func presentViewControllerWithReplacement(viewController: UIViewController) {
        
        let window = self.shared.windows[0] as UIWindow
        
        UIView.transition(
            from: window.rootViewController!.view,
            to: viewController.view,
            duration: 0.65,
            options: .transitionCrossDissolve,
            completion: {
                finished in window.rootViewController = viewController
        })
    }
}
