//
//  Cardable.swift
//  iOSProject
//
//  Created by Keshav on 21/02/18.
//  Copyright © 2018 Keshav. All rights reserved.
//

import UIKit

protocol Cardable {
    var cornerRadius: CGFloat { get }
    func layoutCard()
}

extension Cardable {
    var cornerRadius: CGFloat {
        return 8
    }
}

extension Cardable where Self: UIView {
    func maskedCarner() -> CACornerMask {
        return [.layerMinXMinYCorner,.layerMaxXMinYCorner, .layerMinXMaxYCorner, .layerMaxXMaxYCorner]
    }
    
    func layoutCard() {
        layer.borderColor = UIColor.lightGray.cgColor
        layer.borderWidth = 1
        layer.cornerRadius = cornerRadius
        layer.maskedCorners = maskedCarner()
        layer.backgroundColor = UIColor.white.cgColor
        clipsToBounds = true
        
        layer.masksToBounds = false
        layer.shadowColor = UIColor.lightGray.cgColor
        layer.shadowOpacity = 0.5
        layer.shadowOffset =  CGSize(width: -1, height: 1)
        layer.shadowRadius = 4
        layer.shadowPath = UIBezierPath(rect: bounds).cgPath
        layer.shouldRasterize = true
        layer.rasterizationScale = UIScreen.main.scale
    }
    
}
