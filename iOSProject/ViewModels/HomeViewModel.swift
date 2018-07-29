//
//  HomeViewModel.swift
//  iOSProject
//
//  Created by Keshav on 26/02/18.
//  Copyright © 2018 Keshav. All rights reserved.
//

import UIKit

final class HomeViewModel {
    
    private enum Sections: String, CaseIterable {
        case FireBase
        case MachineLearning
        case AR
        case PageControl
    }
    
    var numberOfRows: Int {
        return Sections.allCases.count
    }

    func cellTitle(at index: Int) -> String {
        return Sections.allCases[index].rawValue
    }

    func segueId(at index: Int) -> String {
        return cellTitle(at: index) + "SegueId"
    }
    
    func registerCells(for collectionView: UICollectionView) {
        collectionView.register(UINib(nibName: HomeViewCollectionViewCell.className, bundle: nil), forCellWithReuseIdentifier: HomeViewCollectionViewCell.identifier)
    }

}
