//
//  ReusableView.swift
//  trakt-involves
//
//  Created by iMac on 27/07/17.
//  Copyright © 2017 Flavio Kruger Bittencourt. All rights reserved.
//

import Foundation
import UIKit

protocol ReusableView: class {}

extension ReusableView where Self: UIView {
  
  static var reuseIdentifier: String {
    return String(describing: self)
  }
}

extension UITableViewCell: ReusableView { }
extension UICollectionViewCell: ReusableView { }
extension UITableViewHeaderFooterView: ReusableView { }
