//
//  Date+iOS.swift
//  iOSProject
//
//  Created by Keshav on 29/03/18.
//  Copyright © 2018 Keshav. All rights reserved.
//

import Foundation

extension Date {
    public func toString(dateFormat format: String = "dd-MMM-yyyy") -> String {
        let dateFormatter = DateFormatter()
        dateFormatter.dateFormat = format
        return dateFormatter.string(from: self)
    }
}
