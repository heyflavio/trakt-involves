//
//  Date+Additions.swift
//  trakt-involves
//
//  Created by iMac on 27/07/17.
//  Copyright © 2017 Flavio Kruger Bittencourt. All rights reserved.
//


import Foundation

extension Date {
    
    func timeString() -> String {
        let dateFormatter = DateFormatter()
        dateFormatter.dateStyle = .none
        dateFormatter.timeStyle = .short
        
        return dateFormatter.string(from: self)
    }
    
    func formatted() -> String {
        let dateFormatter = DateFormatter()
        dateFormatter.dateStyle = .medium
        
        return dateFormatter.string(from: self)
    }

    func ISOTimeFormat() -> String {
        let dateFormatter = DateFormatter()
        dateFormatter.dateFormat = DateFormats.ISOFormat.rawValue
        
        return dateFormatter.string(from: self)
    }

}
