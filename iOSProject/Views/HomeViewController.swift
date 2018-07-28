//
//  HomeViewController.swift
//  iOSProject
//
//  Created by Keshav on 26/02/18.
//  Copyright © 2018 Keshav. All rights reserved.
//

import UIKit
import Keys
import Intents

final class HomeViewController: UIViewController {

    lazy var collectionView: UICollectionView = {
        let collectionView = UICollectionView(frame: CGRect.zero, collectionViewLayout: UICollectionViewFlowLayout.flowLayout(type: .home))
        collectionView.translatesAutoresizingMaskIntoConstraints = false
        collectionView.backgroundColor = UIColor.white
        collectionView.dataSource = self
        collectionView.delegate = self
        return collectionView
    }()

    let viewModel = HomeViewModel()
    let keys = IOSProjectKeys()
    
    override func viewDidLoad() {
        super.viewDidLoad()

        view.iOS_addSubview(collectionView)
        viewModel.registerCells(for: collectionView)
        donateInteraction()
    }

    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        #if RELEASE
            title = Localized.HomeScreen.title
        #elseif DEBUG
            title = Localized.HomeScreen.titleDebug
            print(keys.artsyAPIClientKey)
        #endif
    }
    
    override func viewWillDisappear(_ animated: Bool) {
        super.viewWillDisappear(animated)
        title = Localized.HomeScreen.backButtonTitle
    }
    
    func showScreen(_ index: Int) {
        performSegue(withIdentifier: viewModel.segueId(at: index), sender: nil)
    }
}

extension HomeViewController: UICollectionViewDataSource, UICollectionViewDelegate {
 
    public func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return viewModel.numberOfRows
    }
    
    public func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        if let cell = collectionView.dequeueReusableCell(withReuseIdentifier: HomeViewCollectionViewCell.identifier, for: indexPath) as? HomeViewCollectionViewCell {
            cell.style(title: viewModel.cellTitle(at: indexPath.item))
            return cell
        }
        return UICollectionViewCell()
    }
    
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        collectionView.deselectItem(at: indexPath, animated: true)
        showScreen(indexPath.item)
    }
}


extension HomeViewController {

    func donateInteraction() {
        let intent = PhotoOfTheDayIntent()
        intent.suggestedInvocationPhrase = Localized.HomeScreen.siriShortcutName
        
        let interaction = INInteraction(intent: intent, response: nil)
        interaction.donate { (error) in
            if let error = error as NSError? {
                print("Interaction donation failed: %@", error.description)
            } else {
                print("Successfully donated interaction")
            }
        }
    }
}
