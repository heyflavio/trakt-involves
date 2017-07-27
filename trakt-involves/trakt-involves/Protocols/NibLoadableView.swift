//
//  NibLoadableView.swift
//  trakt-involves
//
//  Created by iMac on 27/07/17.
//  Copyright © 2017 Flavio Kruger Bittencourt. All rights reserved.
//

import Foundation
import UIKit

protocol NibLoadableView: class { }

extension NibLoadableView where Self: UIView {
  
  static var NibName: String {
    return String(describing: self)
  }
}

extension UICollectionViewCell: NibLoadableView { }
extension UITableViewCell: NibLoadableView { }
extension UITableViewHeaderFooterView: NibLoadableView { }
