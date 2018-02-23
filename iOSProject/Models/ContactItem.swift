//
//  ContactItem.swift
//  iOSProject
//
//  Created by Keshav on 13/02/18.
//  Copyright © 2018 Keshav. All rights reserved.
//

import Foundation
import Firebase

struct ContactItem {
  
    let key: String
    let name: String
    let address: String
    let phoneNumber: String
    let ref: DatabaseReference?
  
    init(name: String, address: String, phoneNumber: String, key: String = "") {
        self.key = key
        self.name = name
        self.address = address
        self.phoneNumber = phoneNumber
        self.ref = nil
    }

    init(snapshot: DataSnapshot) {
        key = snapshot.key
        let snapshotValue = snapshot.value as! [String: AnyObject]
        name = snapshotValue["name"] as! String
        address = snapshotValue["address"] as! String
        phoneNumber = snapshotValue["phoneNumber"] as! String
        ref = snapshot.ref
    }

    func toAnyObject() -> Any {
        return [
          "name": name,
          "address": address,
          "phoneNumber": phoneNumber
        ]
    }
  
}
