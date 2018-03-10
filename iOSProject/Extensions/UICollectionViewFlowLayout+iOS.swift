//
//  UICollectionViewFlowLayout+iOS.swift
//  iOSProject
//
//  Created by Keshav on 26/02/18.
//  Copyright © 2018 Keshav. All rights reserved.
//

import UIKit

extension UICollectionViewFlowLayout {
    public static func flowLayout(minimumLineSpacing: CGFloat = 10.0, margin: CGFloat = 8.0) -> UICollectionViewFlowLayout {
        let layout = UICollectionViewFlowLayout()
        layout.scrollDirection = .vertical
        layout.minimumLineSpacing = minimumLineSpacing
        layout.minimumInteritemSpacing = 0
        layout.sectionInset = UIEdgeInsets(top: margin, left: margin, bottom: margin, right: margin)
        layout.itemSize = homeViewItemSize
        return layout
    }
    
    private static var factor: CGFloat {
        return SystemConstant.deviceResolution == .dimension4x ? 1.2 : 1.0
    }
    
    public static var numberOfColumns: CGFloat = 2

    private static var homeViewItemSize: CGSize {
        let width = (SystemConstant.screenWidth - (10 + 8 * numberOfColumns))/numberOfColumns
        let height = width + factor
        return CGSize(width: width, height: height)
    }
}
