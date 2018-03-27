//
//  Place.swift
//  iOSProject
//
//  Created by Keshav on 26/03/18.
//  Copyright © 2018 Keshav. All rights reserved.
//

import Foundation
import CoreLocation
import HDAugmentedReality

final class Place: ARAnnotation {
  let reference: String
  let place: String
  let address: String
  var phoneNumber: String?
  var website: String?
  
  var infoText: String {
    get {
      var info = "Address: \(address)"
      
      if let phoneNumber = phoneNumber {
        info += "\nPhone: \(phoneNumber)"
      }
      
      if let website = website {
        info += "\nweb: \(website)"
      }
      return info
    }
  }
  
  init(location: CLLocation, reference: String, name: String, address: String) {
    place = name
    self.reference = reference
    self.address = address
    super.init(identifier: place, title: place, location: location)!
  }
  
  override var description: String {
    return place
  }
}
