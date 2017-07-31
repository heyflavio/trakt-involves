//
//  AuthenticationManager.swift
//  trakt-involves
//
//  Created by iMac on 26/07/17.
//  Copyright © 2017 Flavio Kruger Bittencourt. All rights reserved.
//

import Foundation
import RxSwift

enum AuthenticationKeys: String {
    case accessTokenKey = "accessToken"
    case refreshTokenKey = "refreshToken"
    case accessTokenExpirationDateKey = "accessTokenExpirationDate"
}

class AuthenticationManager {
    
    static fileprivate var disposeBag = DisposeBag()

    static var accessToken: String? {
        get {
            return UserDefaults.standard.object(forKey: AuthenticationKeys.accessTokenKey.rawValue) as? String ?? nil
        }
        
        set {
            UserDefaults.standard.setValue(newValue, forKey: AuthenticationKeys.accessTokenKey.rawValue)
        }
    }
    
    static var refreshToken: String? {
        get {
            return UserDefaults.standard.object(forKey: AuthenticationKeys.refreshTokenKey.rawValue) as? String ?? nil
        }
        
        set {
            UserDefaults.standard.setValue(newValue, forKey: AuthenticationKeys.refreshTokenKey.rawValue)
        }
    }
    
    static var accessTokenExpirationDate: Date? {
        get {
            return UserDefaults.standard.object(forKey: AuthenticationKeys.accessTokenExpirationDateKey.rawValue) as? Date ?? nil
        }
        
        set {
            UserDefaults.standard.setValue(newValue, forKey: AuthenticationKeys.accessTokenExpirationDateKey.rawValue)
        }
    }
    
    static var isLoggedIn: Bool {
        return AuthenticationManager.accessToken != nil
    }
}

extension AuthenticationManager {
    
    static func getToken(from url: URL) -> Bool {
        
        guard let urlComponents = URLComponents(url: url, resolvingAgainstBaseURL: true),
            let code = urlComponents.queryItems?.first(where: { $0.name == "code" })?.value else {
                return false
        }
        
        AuthenticationAPI.getToken(from: code)
            .subscribeOn(MainScheduler.instance)
            .subscribe( onNext: { authentication in
                AuthenticationManager.accessToken = authentication.accessToken
                AuthenticationManager.refreshToken = authentication.refreshToken
                AuthenticationManager.accessTokenExpirationDate = Date(timeIntervalSinceNow: TimeInterval(authentication.expiresIn!))
                
                self.replaceViewControllerToMain()

            }, onError: { error in
                
            }).addDisposableTo(disposeBag)
        
        return true
    }
    
    static func checkAccessTokenExpirationDate() {
        guard let expiratonDate = accessTokenExpirationDate, expiratonDate < Date() else {
            return
        }
        
        AuthenticationAPI.refreshToken(AuthenticationManager.accessToken!)
            .subscribeOn(MainScheduler.instance)
            .subscribe( onNext: { authentication in
                AuthenticationManager.accessToken = authentication.accessToken
                AuthenticationManager.refreshToken = authentication.refreshToken
                AuthenticationManager.accessTokenExpirationDate = Date(timeIntervalSinceNow: TimeInterval(authentication.expiresIn!))
                
                self.replaceViewControllerToMain()
                
            }, onError: { error in
                
            }).addDisposableTo(disposeBag)
    }
    
    
    static fileprivate func replaceViewControllerToMain() {
        guard let appDelegate = UIApplication.shared.delegate as? AppDelegate else { return }
        appDelegate.replaceViewControllerFromRoot(MainRouter.assembleModule())
    }
    
}
