//
//  UIButton+iOS.swift
//  iOSProject
//
//  Created by Keshav on 28/07/18.
//  Copyright © 2018 Keshav. All rights reserved.
//

import UIKit

extension UIButton {
    func roundedCorders(cornerRadius: CGFloat = 8, borderColor: UIColor = .black, borderWidth: CGFloat = 1) {
        layer.cornerRadius = cornerRadius
        layer.borderColor = borderColor.cgColor
        layer.borderWidth = borderWidth
    }
}
