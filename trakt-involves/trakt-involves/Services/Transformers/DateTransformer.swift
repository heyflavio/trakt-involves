//
//  DateTransformer.swift
//  trakt-involves
//
//  Created by iMac on 29/07/17.
//  Copyright © 2017 Flavio Kruger Bittencourt. All rights reserved.
//

import Foundation
import ObjectMapper

class DateTransformer: TransformType {
    
    public typealias Object = Date
    public typealias JSON = String
    
    let formatter = DateFormatter()
    
    public init() {
        setupDateFormatter()
    }
    
    func transformFromJSON(_ value: Any?) -> Date? {
        if let dateTime = value as? String {
            return formatter.date(from: dateTime)
        }
        
        return nil
    }
    
    func transformToJSON(_ value: Date?) -> String? {
        if let date = value {
            return formatter.string(from: date)
        }
        
        return nil
    }
    
    func setupDateFormatter() {
        formatter.dateFormat = DateFormats.ISOFormat.rawValue
    }
}
