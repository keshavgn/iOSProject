//
//  Setting.swift
//  iOSProject
//
//  Created by Keshav on 14/04/18.
//  Copyright © 2018 Keshav. All rights reserved.
//

import Foundation

enum SearchIndexingPreference: Int {
  case Disabled, ViewedRecords
}

struct Settings {
    static func enableSpotlightSearch(_ enable: Bool) {
        UserDefaults.standard.set(enable ? 1 : 0, forKey: "SearchIndexingPreference")
    }
    
    static var searchIndexingPreference: SearchIndexingPreference {
        let preferenceRawValue = UserDefaults.standard.integer(forKey: "SearchIndexingPreference")
        if let preference = SearchIndexingPreference(rawValue: preferenceRawValue) {
            return preference
        } else {
            return .Disabled
        }
    }
}
