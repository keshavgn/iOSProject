//
//  ContactsSearch.swift
//  iOSProject
//
//  Created by Keshav on 14/04/18.
//  Copyright © 2018 Keshav. All rights reserved.
//

import Foundation
import CoreSpotlight

extension ContactItem {
    public static let domainIdentifier = "com.keshavgn.iOSProject.contact"
    public var userActivityUserInfo: [String: String] {
        return ["id": name]
    }
    
    public var userActivity: NSUserActivity {
        let activity = NSUserActivity(activityType: ContactItem.domainIdentifier)
        activity.title = name
        activity.userInfo = userActivityUserInfo
        activity.keywords = [phoneNumber, address, name]
        return activity
    }

}
