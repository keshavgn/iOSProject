//
//  CGRect+iOS.swift
//  iOSProject
//
//  Created by Keshav on 21/02/18.
//  Copyright © 2018 Keshav. All rights reserved.
//

import UIKit

public extension CGRect {
    
    public func iOS_insetBy(_ edgeInsets: UIEdgeInsets) -> CGRect {
        return CGRect(x: minX + edgeInsets.left,
                      y: minY + edgeInsets.top,
                      width: width - edgeInsets.iOS_horizontal,
                      height: height - edgeInsets.iOS_vertical)
    }
    
    public func iOS_extendBy(_ edgeInsets: UIEdgeInsets) -> CGRect {
        return CGRect(x: minX - edgeInsets.left,
                      y: minY - edgeInsets.top,
                      width: width + edgeInsets.iOS_horizontal,
                      height: height + edgeInsets.iOS_vertical)
    }
    
    public func iOS_contain(point: CGPoint) -> Bool {
        return point.x >= minX && point.x <= maxX && point.y >= minY && point.y <= maxY
    }
    
}
