//
//  AuthManager.swift
//  trakt-involves
//
//  Created by iMac on 26/07/17.
//  Copyright © 2017 Flavio Kruger Bittencourt. All rights reserved.
//

import Foundation


class AuthManager {
    
    static let sharedInstance = AuthManager()
    
    static var isLoggedIn: Bool {
        return true
    }
}
