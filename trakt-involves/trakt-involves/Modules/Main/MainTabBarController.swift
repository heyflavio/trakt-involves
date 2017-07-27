//
//  HomeViewController.swift
//  trakt-involves
//
//  Created by iMac on 26/07/17.
//  Copyright © 2017 Flavio Kruger Bittencourt. All rights reserved.
//

import UIKit

class MainTabBarController: UITabBarController {
    
    var presenter: MainPresenterInputProtocol?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        tabBar.isTranslucent = false
        tabBar.barTintColor = UIColor(red:0.51, green:0.11, blue:0.13, alpha:1.00)
        tabBar.tintColor = .white
        delegate = self
    }
    
    func setTabBarHidden(_ hidden: Bool) {
        self.tabBar.isHidden = hidden
    }
}

extension MainTabBarController: UITabBarControllerDelegate {
    
    func tabBarController(_ tabBarController: UITabBarController, shouldSelect viewController: UIViewController) -> Bool {
        
        return true
    }
    
}

extension MainTabBarController: MainPresenterOutputProtocol {
    
    
}

extension MainTabBarController {
    
}
