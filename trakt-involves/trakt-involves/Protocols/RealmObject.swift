//
//  RealmObject.swift
//  trakt-involves
//
//  Created by Flavio Kruger Bittencourt on 30/07/17.
//  Copyright © 2017 Flavio Kruger Bittencourt. All rights reserved.
//

import Foundation
import RealmSwift

protocol RealmObject {
    func save(with id: Int)
}

extension RealmObject where Self: Object {
    
    func save(with id: Int) {
        let realm = try! Realm()
       
        let count = realm
            .objects(Self.self)
            .filter("id == %@", id)
            .count
   
        try! realm.write {
            realm.add(self, update: count > 0)
        }

    }
}
