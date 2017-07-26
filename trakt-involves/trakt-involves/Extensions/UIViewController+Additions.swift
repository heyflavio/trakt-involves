//
//  UIViewController+Additions.swift
//  trakt-involves
//
//  Created by iMac on 26/07/17.
//  Copyright © 2017 Flavio Kruger Bittencourt. All rights reserved.
//

import Foundation
import SafariServices

protocol KeyboardObservable {
    
    func addKeyboardObservers()
    func keyboardChange(notification: NSNotification)
    func keyboardWillChange(notification: NSNotification, constraint: NSLayoutConstraint)
}

protocol KeyboardDismissible {
    
    func hideKeyboardWhenTappedAround()
}

extension UIViewController {
    
    func present(_ viewController: UIViewController) {
        DispatchQueue.main.async {
            self.present(viewController, animated: true, completion: nil)
        }
    }
    
    func presentSafariViewController(for url: String) {
        let safariVC = SFSafariViewController(url: URL(string: url)!)
        safariVC.navigationController?.navigationBar.isTranslucent = false
        safariVC.preferredBarTintColor = UIColor(red:0.00, green:0.46, blue:0.86, alpha:1.00)
        safariVC.preferredControlTintColor = .white
        self.present(safariVC, animated: true, completion: nil)
    }
    
    func screenIs4inches() -> Bool {
        return UIScreen.main.bounds.size.width < 375
    }
}

extension UIViewController: KeyboardObservable {
    
    func addKeyboardObservers() {
        
        NotificationCenter.default.addObserver(self,
                                               selector: #selector(keyboardChange),
                                               name: .UIKeyboardWillShow,
                                               object: nil)
        
        NotificationCenter.default.addObserver(self,
                                               selector: #selector(keyboardChange),
                                               name: .UIKeyboardWillHide,
                                               object: nil)
    }
    
    func keyboardChange(notification: NSNotification) {}
    
    func keyboardWillChange(notification: NSNotification, constraint: NSLayoutConstraint) {
        
        guard let info = notification.userInfo else { return }
        
        let keyboardFrame = (info[UIKeyboardFrameEndUserInfoKey] as! NSValue).cgRectValue
        let keyboardDuration = info[UIKeyboardAnimationDurationUserInfoKey] as! TimeInterval
        
        constraint.constant = UIScreen.main.bounds.size.height - keyboardFrame.origin.y
        
        UIView.animate(withDuration: keyboardDuration, animations: {
            self.view.layoutIfNeeded()
        })
    }
}

extension UIViewController: KeyboardDismissible {
    
    func hideKeyboardWhenTappedAround() {
        let tapRecognizer = UITapGestureRecognizer(target: self, action: #selector(dismissKeyboard))
        tapRecognizer.delegate = self as? UIGestureRecognizerDelegate
        view.addGestureRecognizer(tapRecognizer)
        tapRecognizer.cancelsTouchesInView = false
    }
    
    func dismissKeyboard() {
        view.endEditing(true)
    }
}
