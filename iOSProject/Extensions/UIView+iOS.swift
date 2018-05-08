//
//  UIView+iOS.swift
//  iOSProject
//
//  Created by Keshav on 21/02/18.
//  Copyright © 2018 Keshav. All rights reserved.
//

import UIKit

extension UIView {
    public struct LayoutMarginOptions: OptionSet {
        
        public typealias RawValue = Int
        public var rawValue: Int
        
        public init(rawValue: Int) {
            self.rawValue = rawValue
        }
        
        static public let left = LayoutMarginOptions(rawValue: 1 << 0)
        static public let right = LayoutMarginOptions(rawValue: 1 << 1)
        static public let top = LayoutMarginOptions(rawValue: 1 << 2)
        static public let bottom = LayoutMarginOptions(rawValue: 1 << 3)
        
        static public let all: LayoutMarginOptions = [.left, .right, .top, .bottom]
    }

    public func iOS_addSubview(_ subview: UIView, margin: UIEdgeInsets = .zero, onLayoutMargin: LayoutMarginOptions = [], maximumSubViewWidth: CGFloat? = nil, maximumSubViewHeight: CGFloat? = nil, at atIndex: Int? = nil) {
        subview.translatesAutoresizingMaskIntoConstraints = false
        
        if let atIndex = atIndex {
            insertSubview(subview, at: atIndex)
        } else {
            addSubview(subview)
        }
        
        let guide = layoutMarginsGuide
        if onLayoutMargin.contains(.left) {
            subview.leftAnchor.constraint(equalTo: guide.leftAnchor, constant: margin.left).isActive = true
        } else {
            subview.leftAnchor.constraint(equalTo: leftAnchor, constant: margin.left).isActive = true
        }
        
        if onLayoutMargin.contains(.right) {
            guide.rightAnchor.constraint(equalTo: subview.rightAnchor, constant: margin.right).isActive = true
        } else {
            rightAnchor.constraint(equalTo: subview.rightAnchor, constant: margin.right).isActive = true
        }

        if onLayoutMargin.contains(.top) {
            subview.topAnchor.constraint(equalTo: guide.topAnchor, constant: margin.top).isActive = true
        } else {
            subview.topAnchor.constraint(equalTo: topAnchor, constant: margin.top).isActive = true
        }
        
        if onLayoutMargin.contains(.bottom) {
            guide.bottomAnchor.constraint(equalTo: subview.bottomAnchor, constant: margin.bottom).isActive = true
        } else {
            bottomAnchor.constraint(equalTo: subview.bottomAnchor, constant: margin.bottom).isActive = true
        }
    }
    
    public func iOS_centerSubview(_ subview: UIView, width: CGFloat, height: CGFloat) {
        subview.translatesAutoresizingMaskIntoConstraints = false
        addSubview(subview)
        subview.centerXAnchor.constraint(equalTo: centerXAnchor).isActive = true
        subview.centerYAnchor.constraint(equalTo: centerYAnchor).isActive = true
        subview.widthAnchor.constraint(equalToConstant: width).isActive = true
        subview.heightAnchor.constraint(equalToConstant: height).isActive = true
    }
    
    public func iOS_addSubviewWithFixedSize(_ subview: UIView, margin: UIEdgeInsets = .zero, maximumSubViewWidth: CGFloat? = nil, maximumSubViewHeight: CGFloat? = nil, onLayoutMargin: LayoutMarginOptions = []) {
        subview.translatesAutoresizingMaskIntoConstraints = false
        addSubview(subview)
        if let maximumSubViewWidth = maximumSubViewWidth {
            subview.widthAnchor.constraint(equalToConstant: maximumSubViewWidth).isActive = true
        }
        
        if onLayoutMargin.contains(.left) {
            subview.leftAnchor.constraint(equalTo: leftAnchor, constant: margin.left).isActive = true
        }
        
        if onLayoutMargin.contains(.right) {
            rightAnchor.constraint(equalTo: subview.rightAnchor, constant: margin.right).isActive = true
        }

        if onLayoutMargin.contains(.top) {
            subview.topAnchor.constraint(equalTo: topAnchor, constant: margin.top).isActive = true
        }
        
        if onLayoutMargin.contains(.bottom) {
            bottomAnchor.constraint(equalTo: subview.bottomAnchor, constant: margin.bottom).isActive = true
        }
        
        if let maximumSubViewHeight = maximumSubViewHeight {
            subview.heightAnchor.constraint(equalToConstant: maximumSubViewHeight).isActive = true
        }
    }

}


extension UIView {
    var className: String {
        return String(describing: type(of: self))
    }
    
    class var className: String {
        return String(describing: self)
    }
}

protocol Identifiable {
    static var identifier: String { get }
}

extension Identifiable where Self: UIView {
    static var identifier: String {
        get {
            return (NSStringFromClass(classForCoder()).components(separatedBy: ".").last ?? "") + "Identifier"
        }
    }
}
