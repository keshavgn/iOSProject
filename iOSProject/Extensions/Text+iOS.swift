//
//  Text+iOS.swift
//  iOSProject
//
//  Created by Keshav on 10/03/18.
//  Copyright © 2018 Keshav. All rights reserved.
//

import Foundation

struct iOSProject {
    private static func text(forKey key: String) -> String {
        return Bundle.main.localizedString(forKey: key, value: nil, table: nil)
    }
    
    public struct Text {
        public struct Home {
            public static var ScreenTitle: String {
                return text(forKey: "home_screen_title")
            }
            public static var BackButtonTitle: String {
                return text(forKey: "home_screen_back_title")
            }
        }
        public struct Contacts {
            public static var ScreenTitle: String {
                return text(forKey: "contacts_screen_title")
            }
            public static var AlertTitle: String {
                return text(forKey: "alert_delete_contact_title")
            }
            public static var AlertDescription: String {
                return text(forKey: "alert_delete_contact_description")
            }
        }
    }

}
