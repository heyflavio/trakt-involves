//
//  RealmObject.swift
//  trakt-involves
//
//  Created by Flavio Kruger Bittencourt on 30/07/17.
//  Copyright © 2017 Flavio Kruger Bittencourt. All rights reserved.
//

import Foundation
import ObjectMapper
import RealmSwift

protocol RealmObject {
    func save(with id: Int)
    func delete()
}

extension RealmObject where Self: Object, Self: Mappable {
    
    func save(with id: Int) {
        let realm = try! Realm()
       
        let count = realm
            .objects(Self.self)
            .filter("id == %@", id)
            .count
   
        var values = self.toJSON()
        let valuesToRemove = values.keys.filter { values[$0]! is NSNull }
        valuesToRemove.forEach { values.removeValue(forKey: $0) }
        
        try! realm.write {
            if count > 0 {
                realm.create(Self.self, value: values, update: true)
            } else {
                realm.add(self, update: false)
            }
        }

    }
    
    func delete() {
        let realm = try! Realm()
        
        try! realm.write {
            realm.delete(self)
        }
    }
}
