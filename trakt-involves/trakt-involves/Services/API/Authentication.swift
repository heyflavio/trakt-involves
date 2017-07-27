//
//  Authentication.swift
//  trakt-involves
//
//  Created by iMac on 26/07/17.
//  Copyright © 2017 Flavio Kruger Bittencourt. All rights reserved.
//

import Foundation

enum AuthenticationKeys: String {
    case tokenKey = "token"
}

class Authentication {
    
    static var token: String? {
        get {
            return UserDefaults.standard.object(forKey: AuthenticationKeys.tokenKey.rawValue) as? String ?? nil
        }
        
        set {
            UserDefaults.standard.setValue(newValue, forKey: AuthenticationKeys.tokenKey.rawValue)
        }
    }

}
