//
//  PageControlViewController.swift
//  iOSProject
//
//  Created by Keshav on 15/07/18.
//  Copyright © 2018 Keshav. All rights reserved.
//

import UIKit

final class PageControlViewController: UIViewController {

    lazy var bottomCollectionView: UICollectionView = {
        let collectionView = UICollectionView(frame: CGRect.zero, collectionViewLayout: UICollectionViewFlowLayout.flowLayout(type: .pageControl))
        collectionView.translatesAutoresizingMaskIntoConstraints = false
        collectionView.backgroundColor = UIColor.white
        collectionView.dataSource = self
        collectionView.delegate = self
        return collectionView
    }()
    
    lazy var topCollectionView: UICollectionView = {
        let collectionView = UICollectionView(frame: CGRect.zero, collectionViewLayout: UICollectionViewFlowLayout.flowLayout(type: .pageView))
        collectionView.translatesAutoresizingMaskIntoConstraints = false
        collectionView.backgroundColor = UIColor.white
        collectionView.dataSource = self
        collectionView.delegate = self
        return collectionView
    }()
    
    lazy var lineView: UIView = {
       let view = UIView()
        view.backgroundColor = UIColor.lightGray
        view.translatesAutoresizingMaskIntoConstraints = false
        return view
    }()
        
    let items = ["Icon1", "Icon2", "Icon3", "Icon4", "Icon5", "Icon6", "Icon7", "Icon8", "Icon9", "Icon10", "Icon11", "Icon12"]
    var selectedIndexPath: IndexPath?
    
    var isScrollingBySelection = true
    
    override func viewDidLoad() {
        super.viewDidLoad()

        title = Localized.Pagecontrol.title
        setupUI()
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        selectedIndexPath = IndexPath(row: 0, section: 0)
        bottomCollectionView.reloadData()
        topCollectionView.reloadData()
    }
    
    private func setupUI() {
        view.iOS_addSubviewWithFixedSize(topCollectionView, margin: UIEdgeInsets(top: 50, left: 0, bottom: 0, right: 0), maximumSubViewHeight: 420, onLayoutMargin:[.left, .right, .top])
        topCollectionView.register(UINib(nibName: PageViewCollectionViewCell.className, bundle: nil), forCellWithReuseIdentifier: PageViewCollectionViewCell.identifier)
        
        view.iOS_addSubviewWithFixedSize(bottomCollectionView, margin: UIEdgeInsets(top: 0, left: 0, bottom: 50, right: 0), maximumSubViewHeight: 100, onLayoutMargin:[.left, .right, .bottom])
        bottomCollectionView.register(UINib(nibName: PageControlCell.className, bundle: nil), forCellWithReuseIdentifier: PageControlCell.identifier)
        
        view.addSubview(lineView)
        lineView.topAnchor.constraint(equalTo: bottomCollectionView.topAnchor, constant: -1).isActive = true
        lineView.leftAnchor.constraint(equalTo: view.leftAnchor).isActive = true
        lineView.rightAnchor.constraint(equalTo: view.rightAnchor).isActive = true
        lineView.heightAnchor.constraint(equalToConstant: 1).isActive = true
        
        if traitCollection.forceTouchCapability == .available {
            registerForPreviewing(with: self, sourceView: topCollectionView)
        }
    }
    
    @objc private func leftIcon() {
        guard let indexPath = selectedIndexPath else { return }
        if indexPath.item > 0 {
            move(next: false)
        }
    }
    
    @objc private func rightIcon() {
        guard let indexPath = selectedIndexPath else { return }
        if indexPath.item < items.count {
            move(next: true)
        }
    }
    
    private func move(next: Bool) {
        guard let indexPath = selectedIndexPath, let cell = bottomCollectionView.cellForItem(at: indexPath) as? PageControlCell else { return }
        cell.isSelected = false
        var row = indexPath.item - 1
        if next {
            row = indexPath.item + 1
        }
        let nextIndexPath = IndexPath(row: row, section: indexPath.section)
        if let cell = bottomCollectionView.cellForItem(at: nextIndexPath) as? PageControlCell {
            cell.isSelected = true
            selectedIndexPath = nextIndexPath
        }
    }
    
    private func showSelectedThumbnail(_ indexPath: IndexPath) {
        if let indexPath = selectedIndexPath, let cell = bottomCollectionView.cellForItem(at: indexPath) as? PageControlCell {
            cell.isSelected = false
        }
        if let cell = bottomCollectionView.cellForItem(at: indexPath) as? PageControlCell {
            cell.isSelected = true
            selectedIndexPath = indexPath
        }
    }
}

extension PageControlViewController: UICollectionViewDataSource, UICollectionViewDelegate {
    
    public func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return items.count
    }
    
    public func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        if collectionView == topCollectionView {
            if let cell = collectionView.dequeueReusableCell(withReuseIdentifier: PageViewCollectionViewCell.identifier, for: indexPath) as? PageViewCollectionViewCell {
                cell.style(icon: items[indexPath.item])
                return cell
            }
        } else {
            if let cell = collectionView.dequeueReusableCell(withReuseIdentifier: PageControlCell.identifier, for: indexPath) as? PageControlCell {
                cell.style(icon: items[indexPath.item])
                cell.isSelected = indexPath == selectedIndexPath ? true : false
                return cell
            }
        }
        return UICollectionViewCell()
    }
    
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        collectionView.deselectItem(at: indexPath, animated: true)
        scrollToItem(collectionView, indexPath: indexPath, scrollToView: true)
        isScrollingBySelection = true
    }
    
    func scrollToItem(_ collectionView: UICollectionView, indexPath: IndexPath, scrollToView: Bool) {
        if scrollToView {
            self.topCollectionView.scrollToItem(at: indexPath, at: .centeredHorizontally, animated: true)
        } else {
            self.bottomCollectionView.scrollToItem(at: indexPath, at: .centeredHorizontally, animated: true)
        }
        showSelectedThumbnail(indexPath)
    }
}

extension PageControlViewController: UIScrollViewDelegate {
    func scrollViewDidScroll(_ scrollView: UIScrollView) {
        // if scrolling is by the user, update the small collection as well
        guard isScrollingBySelection == false, let collectionView = scrollView as? UICollectionView, collectionView == topCollectionView, let layout = collectionView.collectionViewLayout as? UICollectionViewFlowLayout else {
            return
        }
        
        let leftRightMargin = (collectionView.contentInset.left / 2) + (collectionView.contentInset.right / 2)
        let itemAreaWidth = layout.itemSize.width + layout.minimumLineSpacing
        let index = (collectionView.contentOffset.x + leftRightMargin) / itemAreaWidth
        let roundedIndex = Int(round(index))
        var newIndexPath: IndexPath?
        if roundedIndex >= 0 && roundedIndex < items.count {
            newIndexPath = IndexPath(row:roundedIndex, section: 0)
        }
        
        guard let smallLayout = bottomCollectionView.collectionViewLayout as? UICollectionViewFlowLayout, let indexPath = newIndexPath else { return }
        
        // if selected item is not visible on small collection, scroll to it
        showSelectedThumbnail(indexPath)
        UIView.animate(withDuration: 0.3, animations: {
            if let itemFrame = self.bottomCollectionView.layoutAttributesForItem(at: indexPath)?.frame {
                let minNeededOffsetX = itemFrame.maxX + smallLayout.minimumLineSpacing - self.bottomCollectionView.bounds.size.width
                if self.bottomCollectionView.contentOffset.x < minNeededOffsetX {
                    self.bottomCollectionView.setContentOffset(CGPoint(x: minNeededOffsetX, y: 0), animated: false)
                } else if itemFrame.minX < self.bottomCollectionView.contentOffset.x {
                    self.bottomCollectionView.setContentOffset(CGPoint(x: itemFrame.minX - self.bottomCollectionView.contentInset.left, y: 0), animated: false)
                }
            }
        })
    }
    
    func scrollViewWillBeginDragging(_ scrollView: UIScrollView) {
        isScrollingBySelection = false
    }
}


extension PageControlViewController: UIViewControllerPreviewingDelegate {
    func previewingContext(_ previewingContext: UIViewControllerPreviewing, viewControllerForLocation location: CGPoint) -> UIViewController? {
        guard let indexPath = topCollectionView.indexPathForItem(at: location) else { return nil }
        let peekToViewController = PeekToViewController()
        peekToViewController.setImage(items[indexPath.item])
        return peekToViewController
    }
    
    func previewingContext(_ previewingContext: UIViewControllerPreviewing, commit viewControllerToCommit: UIViewController) {
        show(viewControllerToCommit, sender: self)
    }
}
