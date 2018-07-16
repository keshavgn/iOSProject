//
//  UICollectionViewFlowLayout+iOS.swift
//  iOSProject
//
//  Created by Keshav on 26/02/18.
//  Copyright © 2018 Keshav. All rights reserved.
//

import UIKit

public enum ScreenType {
    case home
    case pageControl
    case pageView
}

extension UICollectionViewFlowLayout {
    public static func flowLayout(minimumLineSpacing: CGFloat = 10.0, margin: CGFloat = 8.0, type: ScreenType) -> UICollectionViewFlowLayout {
        let layout = UICollectionViewFlowLayout()
        layout.scrollDirection = scrollDirection(type)
        layout.minimumLineSpacing = minimumLineSpacing
        layout.minimumInteritemSpacing = 0
        layout.sectionInset = UIEdgeInsets(top: margin, left: margin, bottom: margin, right: margin)
        layout.itemSize = itemSize(type)
        return layout
    }
    
    private static var factor: CGFloat {
        return SystemConstant.deviceResolution == .dimension4x ? 1.2 : 1.0
    }
    
    public static var numberOfColumns: CGFloat = 2

    private static func itemSize(_ type: ScreenType) -> CGSize {
        switch type {
        case .home:
            let width = (SystemConstant.screenWidth - (10 + 8 * numberOfColumns))/numberOfColumns
            let height = width + factor
            return CGSize(width: width, height: height)
        case .pageControl:
            return CGSize(width: 50, height: 50)
        case .pageView:
            let width = SystemConstant.screenWidth - 20
            let height = width + factor
            return CGSize(width: width, height: height)
        }
    }
    
    private static func scrollDirection(_ type: ScreenType) -> UICollectionView.ScrollDirection {
        switch type {
        case .home:
            return .vertical
        case .pageControl, .pageView:
            return .horizontal
        }
    }
}
