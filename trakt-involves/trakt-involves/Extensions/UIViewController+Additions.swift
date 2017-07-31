//
//  UIViewController+Additions.swift
//  trakt-involves
//
//  Created by iMac on 26/07/17.
//  Copyright © 2017 Flavio Kruger Bittencourt. All rights reserved.
//

import Foundation
import SafariServices

extension UIViewController {
    
    func present(_ viewController: UIViewController) {
        DispatchQueue.main.async {
            self.present(viewController, animated: true, completion: nil)
        }
    }
}

