//
//  CardViewLayoutable.swift
//  iOSProject
//
//  Created by Keshav on 21/02/18.
//  Copyright © 2018 Keshav. All rights reserved.
//

import UIKit

public class CardViewLayer: CALayer {
    
    fileprivate struct Constant {
        static let shadowSpace: CGFloat = 20
        static let defaultExcludeLayoutMargins: UIEdgeInsets = UIEdgeInsets(top: 8, left: 8, bottom: 8, right: 8)
        static let CardLayerPropertyName = "CardLayoutable.CardLayer"
        static let SeparatorLinePropertyName = "CardLayoutable.CardLayer.SeparatorLine"
    }
    
    public struct CardViewConfiguration {
        var baseBackgroundColor: UIColor = UIColor.clear
        var cardViewBackgroundColor: UIColor = UIColor.white
        var cardViewBorderWidth: CGFloat = 1.0
        var cardViewBorderColor: UIColor = UIColor.clear
        var shadowColor: UIColor = UIColor.black
        var shadowRadius: CGFloat = 10
        var shadowOpacity: Float = 0.08
        var cornerRadius: CGFloat = 8
        var separatorInsets: UIEdgeInsets = UIEdgeInsets(top: 0, left: 11, bottom: 0, right: 11)
        var separatorLineWidth: CGFloat = 1 / UIScreen.main.scale
        var separatorLineColor: UIColor = UIColor.lightGray
        var showSeparatorLine: Bool = true
        var showCardLayer: Bool = true
        var relativeMargins: RelativeMargin = .horizontal
        var shouldRespectVerticalSafeAreaInsets: Bool = true
        var contentEdgeInsets: UIEdgeInsets = UIEdgeInsets(top: 12, left: 12, bottom: 12, right: 12)
        var cardEdgeInsets: UIEdgeInsets = UIEdgeInsets(top: 8, left: 16, bottom: 8, right: 16)
        var cardViewPosition: CardViewPosition = .single
        var horizontalPosition: HorizontalPosition = .single

        static var cardView: CardViewConfiguration {
            var defaultCardConfig = CardViewConfiguration()
            defaultCardConfig.shadowRadius = 0
            defaultCardConfig.shadowOpacity = 0
            defaultCardConfig.cardViewBorderWidth = 0.5
            defaultCardConfig.cardViewBackgroundColor = UIColor.white
            defaultCardConfig.cardViewBorderColor = UIColor.lightGray
            defaultCardConfig.contentEdgeInsets = UIEdgeInsets(top: 4, left: 18, bottom: 4, right: 18)
            defaultCardConfig.cardEdgeInsets = UIEdgeInsets(top: 0, left: 8, bottom: 0, right: 8)
            return defaultCardConfig
        }
        
        fileprivate var shouldShowSeparatorLine: Bool {
            return cardViewPosition == .top || cardViewPosition == .middle
        }
        
        fileprivate var rectCorner: UIRectCorner {
            switch cardViewPosition {
            case .top:
                switch horizontalPosition {
                case .left:
                    return [.topLeft]
                case .right:
                    return [.topRight]
                case .single:
                    return [.topLeft, .topRight]
                default:
                    return []
                }
            case .middle:
                return []
            case .bottom:
                switch horizontalPosition {
                case .left:
                    return [.bottomLeft]
                case .right:
                    return [.bottomRight]
                case .single:
                    return [.bottomLeft, .bottomRight]
                default:
                    return []
                }
            default:
                switch horizontalPosition {
                case .left:
                    return [.topLeft, .bottomLeft]
                case .right:
                    return [.topRight, .bottomRight]
                case .single:
                    return .allCorners
                default:
                    return []
                }
            }
        }
        
        fileprivate func filteredLayoutMargins(with contentEdgeInsets: UIEdgeInsets, cardViewEdgeInsets: UIEdgeInsets) -> UIEdgeInsets {
            let adjustedCardEdgeInsets = showCardLayer == true ? cardViewEdgeInsets : .zero
            var totalLayoutMargins = contentEdgeInsets + adjustedCardEdgeInsets
            
            if cardViewPosition == .top || cardViewPosition == .middle {
                totalLayoutMargins.bottom -= adjustedCardEdgeInsets.bottom
            }
            if cardViewPosition == .bottom || cardViewPosition == .middle {
                totalLayoutMargins.top -= adjustedCardEdgeInsets.top
            }
            
            if horizontalPosition == .left || horizontalPosition == .middle {
                totalLayoutMargins.right -= adjustedCardEdgeInsets.right
            }
            if horizontalPosition == .right || horizontalPosition == .middle {
                totalLayoutMargins.left -= adjustedCardEdgeInsets.left
            }
            return totalLayoutMargins
        }
        
        func updateLayoutIfNeeded(configuration: CardViewConfiguration?) -> Bool {
            
            guard let configuration = configuration else {
                return true
            }
            
            return cardViewPosition != configuration.cardViewPosition ||
                horizontalPosition != configuration.horizontalPosition ||
                
                contentEdgeInsets != configuration.contentEdgeInsets ||
                cardEdgeInsets != configuration.cardEdgeInsets ||
                
                shadowRadius != configuration.shadowRadius ||
                
                cornerRadius != configuration.cornerRadius ||
                separatorInsets != configuration.separatorInsets ||
                showSeparatorLine != configuration.showSeparatorLine ||
                showCardLayer != configuration.showCardLayer ||
                relativeMargins != configuration.relativeMargins
        }
    }
    
    public enum HorizontalPosition: Int {
        case left = 0
        case middle
        case right
        case single
        
        public init(row: NSInteger, numberOfRows: Int) {
            if numberOfRows > 1 {
                if row == 0 {
                    self = .left
                } else if row >= numberOfRows - 1 {
                    self = .right
                } else {
                    self = .middle
                }
            } else {
                self = .single
            }
        }
        
        public func clip(edgeInsets: UIEdgeInsets) -> UIEdgeInsets {
            var clippedEdgeInsets = edgeInsets
            if self == .left || self == .middle {
                clippedEdgeInsets.right = 0
            }
            if self == .right || self == .middle {
                clippedEdgeInsets.left = 0
            }
            return clippedEdgeInsets
        }
    }
    
    public enum CardViewPosition: Int {
        case top = 0
        case middle
        case bottom
        case single
        
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
        
        public func clip(edgeInsets: UIEdgeInsets) -> UIEdgeInsets {
            var clippedEdgeInsets = edgeInsets
            if self == .top || self == .middle {
                clippedEdgeInsets.bottom = 0
            }
            if self == .bottom || self == .middle {
                clippedEdgeInsets.top = 0
            }
            return clippedEdgeInsets
        }
        
    }
    
    var clippingLayer: CALayer = CALayer()
    var backgroundViewLayer: CAShapeLayer = CAShapeLayer()
    var borderLayer: CAShapeLayer = CAShapeLayer()
    var separatorLayer: CALayer = CALayer()
    
    var configuration: CardViewConfiguration? {
        didSet {
            if configuration?.updateLayoutIfNeeded(configuration: oldValue) ?? (oldValue != nil) {
                setNeedsLayout()
            }
        }
    }
    
    fileprivate func prepareLayers() {
        masksToBounds = false
        clippingLayer.masksToBounds = true
        insertSublayer(clippingLayer, at: 0)
        clippingLayer.insertSublayer(backgroundViewLayer, at: 0)
        clippingLayer.insertSublayer(borderLayer, at: 1)
    }
    
    public override func layoutSublayers() {
        super.layoutSublayers()
        guard let configuration = configuration, configuration.showCardLayer else {
            isHidden = true
            return
        }
        isHidden = false
        layoutClipingLayer(with: configuration)
        layoutBackgroundLayer(with: configuration, clippingLeftExtraInset: clippingLayer.frame.minX, clippingTopExtraInset: clippingLayer.frame.minY)
        layoutBorderLayer(with: configuration, at: backgroundViewLayer.frame)
    }
    
    private func layoutClipingLayer(with configuration: CardViewLayer.CardViewConfiguration) {
        let position = configuration.cardViewPosition
        let horizontalPosition = configuration.horizontalPosition
        let clippingTopExtraInset: CGFloat = position == .top || position == .single ? -Constant.shadowSpace : 0
        let clippingBottomExtraInset: CGFloat = position == .bottom || position == .single ? -Constant.shadowSpace : 0
        let clippingLeftExtraInset: CGFloat = horizontalPosition == .left || horizontalPosition == .single ? -Constant.shadowSpace : 0
        let clippingRightExtraInset: CGFloat = horizontalPosition == .right || horizontalPosition == .single ? -Constant.shadowSpace : 0
        
        clippingLayer.frame = CGRect(x: clippingLeftExtraInset, y: clippingTopExtraInset, width: bounds.width - (clippingLeftExtraInset + clippingRightExtraInset), height: bounds.height - (clippingTopExtraInset + clippingBottomExtraInset))
        
    }
    
    private func layoutBackgroundLayer(with configuration: CardViewLayer.CardViewConfiguration, clippingLeftExtraInset: CGFloat, clippingTopExtraInset: CGFloat) {
        let position = configuration.cardViewPosition
        let horizontalPosition = configuration.horizontalPosition
        var clippingEdgeInsets = configuration.cardEdgeInsets
        clippingEdgeInsets = position.clip(edgeInsets: clippingEdgeInsets)
        clippingEdgeInsets = horizontalPosition.clip(edgeInsets: clippingEdgeInsets)
        backgroundViewLayer.frame = CGRect(x: clippingEdgeInsets.left - clippingLeftExtraInset, y: clippingEdgeInsets.top - clippingTopExtraInset, width: bounds.width - clippingEdgeInsets.iOS_horizontal, height: bounds.height - clippingEdgeInsets.iOS_vertical)
        let maskPath = UIBezierPath(roundedRect: backgroundViewLayer.bounds, byRoundingCorners: configuration.rectCorner, cornerRadii: CGSize(width: configuration.cornerRadius, height: configuration.cornerRadius))
        backgroundViewLayer.path = maskPath.cgPath
        backgroundViewLayer.shadowPath = maskPath.cgPath
    }
    
    private func layoutBorderLayer(with configuration: CardViewLayer.CardViewConfiguration, at frame: CGRect) {
        let position = configuration.cardViewPosition
        let horizontalPosition = configuration.horizontalPosition
        var bounds = frame
        bounds.origin = .zero
        
        let borderTopExtraInset: CGFloat = position == .top || position == .single ? configuration.cardViewBorderWidth / 2 : -configuration.cardViewBorderWidth
        let borderBottomExtraInset: CGFloat = position == .bottom || position == .single ? configuration.cardViewBorderWidth / 2 : -configuration.cardViewBorderWidth
        let borderLeftExtraInset: CGFloat = horizontalPosition == .left || horizontalPosition == .single ? configuration.cardViewBorderWidth / 2 : -configuration.cardViewBorderWidth
        let borderRightExtraInset: CGFloat = horizontalPosition == .right || horizontalPosition == .single ? configuration.cardViewBorderWidth / 2 : -configuration.cardViewBorderWidth
        let borderPath = UIBezierPath(roundedRect: bounds.iOS_insetBy(UIEdgeInsets(top: borderTopExtraInset, left: borderLeftExtraInset, bottom: borderBottomExtraInset, right: borderRightExtraInset)), byRoundingCorners: configuration.rectCorner, cornerRadii: CGSize(width: configuration.cornerRadius, height: configuration.cornerRadius))
        borderLayer.frame = frame
        borderLayer.path = borderPath.cgPath
    }
    
    fileprivate func apply(configuration: CardViewConfiguration) {
        backgroundViewLayer.shadowOffset = .zero
        backgroundViewLayer.shadowColor = configuration.shadowColor.cgColor
        backgroundViewLayer.shadowRadius = configuration.shadowRadius
        backgroundViewLayer.shadowOpacity = configuration.shadowOpacity
        backgroundViewLayer.fillColor = configuration.cardViewBackgroundColor.cgColor
        borderLayer.lineWidth = configuration.cardViewBorderWidth
        borderLayer.strokeColor = configuration.cardViewBorderColor.cgColor
        borderLayer.fillColor = UIColor.clear.cgColor
        self.configuration = configuration
    }
}

extension CardViewLayer {
    
    struct RelativeMargin: OptionSet {
        static let left: RelativeMargin = RelativeMargin(rawValue: 1 << 0)
        static let right: RelativeMargin = RelativeMargin(rawValue: 1 << 1)
        static let top: RelativeMargin = RelativeMargin(rawValue: 1 << 2)
        static let bottom: RelativeMargin = RelativeMargin(rawValue: 1 << 3)
        static let horizontal: RelativeMargin = [.left, .right]
        static let vertical: RelativeMargin = [.top, .bottom]
        static let all: RelativeMargin = [.left, .right, .top, .bottom]
        static let none: RelativeMargin = []
        let rawValue: Int
        
        func edgeInsets(of view: UIView) -> UIEdgeInsets {
            var edgeInsets = UIEdgeInsets.zero
            if contains(.left) {
                edgeInsets.left = max(0, view.layoutMargins.left - Constant.defaultExcludeLayoutMargins.left) - view.safeAreaInsets.left
            }
            if contains(.right) {
                edgeInsets.right = max(0, view.layoutMargins.right - Constant.defaultExcludeLayoutMargins.right) - view.safeAreaInsets.right
            }
            if contains(.top) {
                edgeInsets.top = max(0, view.layoutMargins.top - Constant.defaultExcludeLayoutMargins.top) - view.safeAreaInsets.top
            }
            if contains(.bottom) {
                edgeInsets.bottom = max(0, view.layoutMargins.bottom - Constant.defaultExcludeLayoutMargins.bottom) - view.safeAreaInsets.bottom
            }
            return edgeInsets
        }
    }
}

public protocol CardViewLayoutable: class {
    var cardViewConfiguration: CardViewLayer.CardViewConfiguration { get set }
    var cardViewContainerLayer: CALayer? { get }
    var separatorLineLayer: CALayer? { get }
    var contentContainerView: UIView? { get }
    var position: CardViewLayer.CardViewPosition { get set }
    var cardEdgeInsets: UIEdgeInsets { get set }
    var contentEdgeInsets: UIEdgeInsets { get set }
    var cardRect: CGRect { get }
    func layoutCardView()
    func contentSizeDidChange()
}

extension CardViewLayoutable {
 
    var cardLayer: CardViewLayer {
        if let existedLayer = cardViewContainerLayer?.value(forKey: CardViewLayer.Constant.CardLayerPropertyName) as? CardViewLayer {
            return existedLayer
        } else {
            let layer = CardViewLayer()
            layer.prepareLayers()
            cardViewContainerLayer?.insertSublayer(layer, at: 0)
            cardViewContainerLayer?.setValue(layer, forKey: CardViewLayer.Constant.CardLayerPropertyName)
            return layer
        }
    }
    
    func contentSizeDidChange() {
        contentContainerView?.setNeedsLayout()
        contentContainerView?.layoutIfNeeded()
    }
    
    func styleShadowCard() {
        cardViewConfiguration.cardEdgeInsets = UIEdgeInsets(top: 8, left: 16, bottom: 8, right: 16)
        cardViewConfiguration.cardViewBackgroundColor = UIColor.white
        cardViewConfiguration.cardViewBorderWidth = 0
        cardViewConfiguration.shadowRadius = 4
        cardViewConfiguration.shadowOpacity = 0.1
        cardViewConfiguration.shadowColor = UIColor.black
    }
    
    var separatorLineLayer: CALayer? {
        if let existedLayer = cardViewContainerLayer?.value(forKey: CardViewLayer.Constant.SeparatorLinePropertyName) as? CAShapeLayer {
            return existedLayer
        } else {
            let layer = CAShapeLayer()
            cardViewContainerLayer?.insertSublayer(layer, above: cardLayer)
            cardViewContainerLayer?.setValue(layer, forKey: CardViewLayer.Constant.SeparatorLinePropertyName)
            return layer
        }
    }
}

extension CardViewLayoutable where Self: UIView {
    var cardRect: CGRect {
        let contentLayoutMargins = cardViewConfiguration.relativeMargins.edgeInsets(of: self) + safeAreaInsets
        var adjustedCardEdgeInsets = position.clip(edgeInsets: cardEdgeInsets)
        adjustedCardEdgeInsets = horizontalPosition.clip(edgeInsets: adjustedCardEdgeInsets)
        let layoutMargins = contentLayoutMargins + (cardViewConfiguration.showCardLayer ? adjustedCardEdgeInsets : .zero)
        return bounds.iOS_insetBy(layoutMargins)
    }

    var cardEdgeInsets: UIEdgeInsets {
        get {
            return cardViewConfiguration.cardEdgeInsets
        } set {
            cardViewConfiguration.cardEdgeInsets = newValue
            setNeedsLayout()
            layoutMarginsDidChange()
        }
    }
    
    var contentEdgeInsets: UIEdgeInsets {
        get {
            return cardViewConfiguration.contentEdgeInsets
        } set {
            cardViewConfiguration.contentEdgeInsets = newValue
            setNeedsLayout()
            layoutMarginsDidChange()
        }
    }
    
    var position: CardViewLayer.CardViewPosition {
        get {
            return cardViewConfiguration.cardViewPosition
        } set {
            cardViewConfiguration.cardViewPosition = newValue
            setNeedsLayout()
        }
    }
    
    var horizontalPosition: CardViewLayer.HorizontalPosition {
        get {
            return cardViewConfiguration.horizontalPosition
        } set {
            cardViewConfiguration.horizontalPosition = newValue
            setNeedsLayout()
        }
    }
    
    func layoutCardView() {
        
        guard let containerView = contentContainerView else {
            return
        }
        
        cardViewContainerLayer?.masksToBounds = false
        backgroundColor = cardViewConfiguration.baseBackgroundColor
        containerView.backgroundColor = UIColor.clear
        preservesSuperviewLayoutMargins = true
        containerView.preservesSuperviewLayoutMargins = false
        var contentLayoutMargins = cardViewConfiguration.relativeMargins.edgeInsets(of: self)
        let newLayoutMargins = cardViewConfiguration.filteredLayoutMargins(with: contentLayoutMargins + contentEdgeInsets,
                                                                       cardViewEdgeInsets: cardEdgeInsets)
        if newLayoutMargins != containerView.layoutMargins {
            containerView.layoutMargins = newLayoutMargins
            contentSizeDidChange()
        }
        
        contentLayoutMargins += cardViewConfiguration.shouldRespectVerticalSafeAreaInsets ? safeAreaInsets : UIEdgeInsets(top: 0, left: safeAreaInsets.left, bottom: 0, right: safeAreaInsets.right)
        
        cardLayer.frame = bounds.iOS_insetBy(contentLayoutMargins)
        cardLayer.apply(configuration: cardViewConfiguration)
        separatorLineLayer?.frame = CGRect(x: cardRect.minX + cardViewConfiguration.separatorInsets.left, y: bounds.height - cardViewConfiguration.separatorLineWidth, width: cardRect.width - cardViewConfiguration.separatorInsets.iOS_horizontal, height: cardViewConfiguration.separatorLineWidth)
        separatorLineLayer?.isHidden = cardViewConfiguration.showSeparatorLine == false || cardViewConfiguration.shouldShowSeparatorLine == false
        separatorLineLayer?.backgroundColor = cardViewConfiguration.separatorLineColor.cgColor
        
        if let tableViewCell = self as? UITableViewCell {
            tableViewCell.selectionStyle = .none
        }
    }
}

extension CardViewLayoutable where Self: UIView {
    var cardViewContainerLayer: CALayer? {
        return layer
    }
}

extension CardViewLayoutable where Self: UICollectionViewCell {
    var contentContainerView: UIView? {
        return contentView
    }
}

extension CardViewLayoutable where Self: UITableViewCell {
    var contentContainerView: UIView? {
        return contentView
    }
    
    func adjustAccessoryViewPostion() {
        guard accessoryType != .none else {
            return
        }
        
        if let accessoryView = subviews.first(where: { (view) -> Bool in
            return view is UIButton
        }) {
            accessoryView.frame.origin.x = frame.width - layoutMargins.right - contentEdgeInsets.right - accessoryView.frame.width
        }
    }
    
    func applyCardViewConfiguration(with configuration: CardViewConfiguration) {
        if let contentEdgeInset = configuration.contentEdgeInset {
            cardViewConfiguration.contentEdgeInsets = contentEdgeInset
        }
        if let cardEdgeInset = configuration.cardEdgeInset {
            cardViewConfiguration.cardEdgeInsets = cardEdgeInset
        }
        
        cardViewConfiguration.showCardLayer = configuration.shouldShowCardView
        cardViewConfiguration.showSeparatorLine = configuration.shouldShowSeparatorLine
        accessoryType = configuration.accessoryType
        selectionStyle = configuration.selectionStyle
        
        if let separatorInset = configuration.separatorInset {
            self.separatorInset = separatorInset
        }
    }
}

