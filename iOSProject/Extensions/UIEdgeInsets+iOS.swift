//
//  UIEdgeInsets+iOS.swift
//  iOSProject
//
//  Created by Keshav on 21/02/18.
//  Copyright © 2018 Keshav. All rights reserved.
//

import UIKit
import UIKit.UIGeometry

public extension UIEdgeInsets {

    public static func iOS_edgeInsets(with all: CGFloat) -> UIEdgeInsets {
        return UIEdgeInsets(top: all, left: all, bottom: all, right: all)
    }
    
    public static func +(lhs: UIEdgeInsets, rhs: UIEdgeInsets) -> UIEdgeInsets {
        return UIEdgeInsets(top: lhs.top + rhs.top,
                            left: lhs.left + rhs.left,
                            bottom: lhs.bottom + rhs.bottom,
                            right: lhs.right + rhs.right)
    }
    
    public static func -(lhs: UIEdgeInsets, rhs: UIEdgeInsets) -> UIEdgeInsets {
        return UIEdgeInsets(top: lhs.top - rhs.top,
                            left: lhs.left - rhs.left,
                            bottom: lhs.bottom - rhs.bottom,
                            right: lhs.right - rhs.right)
    }

    public static func +=( lhs: inout UIEdgeInsets, rhs: UIEdgeInsets) {
        lhs = lhs + rhs
    }
    
    public static func -=( lhs: inout UIEdgeInsets, rhs: UIEdgeInsets) {
        lhs = lhs - rhs
    }
    
    public var iOS_horizontal: CGFloat {
        return left + right
    }
    
    public var iOS_vertical: CGFloat {
        return top + bottom
    }
    
    public var iOS_onlyHorizontal: UIEdgeInsets {
        return UIEdgeInsets(top: 0, left: left, bottom: 0, right: right)
    }
    
#if swift(>=4.2)
    public static let zero = UIEdgeInsets()
    public static let UIEdgeInsetsZero = UIEdgeInsets()
#endif
}
