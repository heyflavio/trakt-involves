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
        tabBar.tintColor = UIColor.red
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
