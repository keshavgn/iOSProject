//
//  CardViewConfiguration.swift
//  iOSProject
//
//  Created by Keshav on 21/02/18.
//  Copyright © 2018 Keshav. All rights reserved.
//

import UIKit

public struct CardViewConfiguration {

    public var contentEdgeInset: UIEdgeInsets?
    public var cardEdgeInset: UIEdgeInsets?
    public var separatorInset: UIEdgeInsets?
    public var height: CGFloat
    public var isAllowHighlight: Bool {
        didSet {
            selectionStyle = isAllowHighlight == true ? selectionStyle : .none
        }
    }
    public var shouldShowCardView: Bool
    public var shouldShowSeparatorLine: Bool
    public var accessoryType: UITableViewCellAccessoryType
    public var selectionStyle: UITableViewCellSelectionStyle

    public init(contentEdgeInset: UIEdgeInsets? = nil,
         cardEdgeInset: UIEdgeInsets? = nil,
         separatorInset: UIEdgeInsets? = nil,
         height: CGFloat = -1,
         isAllowHighlight: Bool = true,
         shouldShowCardView: Bool = true,
         shouldShowSeparatorLine: Bool = true,
         accessoryType: UITableViewCellAccessoryType = .none,
         selectionStyle: UITableViewCellSelectionStyle = .default) {
        self.contentEdgeInset = contentEdgeInset
        self.cardEdgeInset = cardEdgeInset
        self.separatorInset = separatorInset
        self.height = height
        self.isAllowHighlight = isAllowHighlight
        self.shouldShowCardView = shouldShowCardView
        self.shouldShowSeparatorLine = shouldShowSeparatorLine
        self.accessoryType = accessoryType
        self.selectionStyle = selectionStyle
    }
}
