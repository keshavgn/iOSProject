//
//  HomeViewModel.swift
//  iOSProject
//
//  Created by Keshav on 26/02/18.
//  Copyright © 2018 Keshav. All rights reserved.
//

import UIKit

final class HomeViewModel {
    
    private var homeViewCellNames: [String] {
        return ["FireBase", "MachineLearning", "AR", "PageControl"]
    }
    
    var numberOfRows: Int {
        return homeViewCellNames.count
    }

    func cellTitle(at index: Int) -> String {
        return homeViewCellNames[index]
    }

    func segueId(at index: Int) -> String {
        return homeViewCellNames[index] + "SegueId"
    }
    
    func registerCells(for collectionView: UICollectionView) {
        collectionView.register(UINib(nibName: HomeViewCollectionViewCell.className, bundle: nil), forCellWithReuseIdentifier: HomeViewCollectionViewCell.identifier)
    }

}
