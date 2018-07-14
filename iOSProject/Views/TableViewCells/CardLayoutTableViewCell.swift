//
//  CardLayoutTableViewCell.swift
//  iOSProject
//
//  Created by Keshav on 22/02/18.
//  Copyright © 2018 Keshav. All rights reserved.
//

import UIKit

class CardLayoutTableViewCell: UITableViewCell, Cardable {
    var maskedCarner: CACornerMask = [.layerMinXMinYCorner,.layerMaxXMinYCorner, .layerMinXMaxYCorner, .layerMaxXMaxYCorner]
    
    public enum Position {
        case top, middle, bottom, single
        
        public init(row: NSInteger, numberOfRows: Int) {
            if numberOfRows > 1 {
                if row == 0 {
                    self = .top
                } else if row >= numberOfRows - 1 {
                    self = .bottom
                } else {
                    self = .middle
                }
            } else {
                self = .single
            }
        }
    }
    
    public enum SeparatorLineStyle {
        case none, single
    }
    
    public var position: Position = .single {
        didSet {
            updateSeparatorLineVisibility()
            setNeedsLayout()
        }
    }

    public var cardEdgeInset: UIEdgeInsets {
        get {
            return UIEdgeInsets(top: topInset, left: leftInset, bottom: bottomInset, right: rightInset)
        }
        set {
            leftInset = newValue.left
            rightInset = newValue.right
            bottomInset = newValue.bottom
            topInset = newValue.top
        }
    }
    

    @IBInspectable public var topInset: CGFloat = 0
    @IBInspectable public var leftInset: CGFloat = 8
    @IBInspectable public var bottomInset: CGFloat = 0
    @IBInspectable public var rightInset: CGFloat = 8
    
    private var _separatorInset: UIEdgeInsets = UIEdgeInsets(top: 0, left: 16, bottom: 0, right: 0)
    
    // Bypass default seperatorInset setter to prevent layoutMargin adjusting value.
    override open var separatorInset: UIEdgeInsets {
        get {
            return _separatorInset
        }
        set {
            _separatorInset = newValue
        }
    }
    
    private var separatorLine: UIView
    
    override open func layoutMarginsDidChange() {
        super.layoutMarginsDidChange()
    }
    
    static public var identifier: String {
        get {
            return NSStringFromClass(classForCoder()).components(separatedBy: ".").last! + "Identifier"
        }
    }

    private struct Constant {
        static let CardShadowExtraSpace: CGFloat = 1
        static let CardHighlightPadding: CGFloat = 3
        static let CardShadowRadius: CGFloat = 0.3
        static let CardShadowOpacity: Float = 0.3
        static let SelectionAnimationDuration: TimeInterval = 0.325
        static let TableViewContentInsetIgnoreValue: CGFloat = 8
    }
    
    // 17 = default value of left(right) margin(8) + subtracted value in the `leftCardConstraintConstant` (computed property)
    public static let defaultStaticCardMarginEdgeInset = UIEdgeInsets(top: 0, left: 17, bottom: 0, right: 17)
    
    // MARK: - View Lifecycle
    
    override public init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        separatorLine = UIView()
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        commonInit()
    }
    
    /**
     
     Overriden default `init?(coder aDecoder: NSCoder)
     
     */
    
    required public init?(coder aDecoder: NSCoder) {
        
        separatorLine = UIView()
        super.init(coder: aDecoder)
        commonInit()
    }

    open func commonInit() {
        preservesSuperviewLayoutMargins = true
        contentView.preservesSuperviewLayoutMargins = false
        // It's neede for the first time if content view height < subview's constraint then constraint break warning will appear.
        contentView.bounds = CGRect(origin: .zero, size: CGSize(width: CGFloat.greatestFiniteMagnitude, height: CGFloat.greatestFiniteMagnitude))
        setupDefaultHeightConstraint()
        setupCardBackgroundView()
        setupSeparatorLine()
        
        backgroundColor = UIColor.clear
    }

    private func setupDefaultHeightConstraint() {
        for constraint in contentView.constraints {
            if constraint.firstAttribute == .height && constraint.firstItem === self {
                removeConstraint(constraint)
                break
            }
        }
    }
    
    private func setupCardBackgroundView() {
        
    }
    
    private func setupSeparatorLine() {
        
        
    }
    
    func updateSeparatorLineVisibility() {
    }

}
