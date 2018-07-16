//
//  PageControlCell.swift
//  iOSProject
//
//  Created by Keshav on 15/07/18.
//  Copyright © 2018 Keshav. All rights reserved.
//

import UIKit

class PageControlCell: UICollectionViewCell, Identifiable {

    @IBOutlet weak var imageView: UIImageView!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        imageView.translatesAutoresizingMaskIntoConstraints = false
    }

    override var isSelected: Bool {
        didSet {
            UIView.animate(withDuration: 0.4, animations: {
                if self.isSelected {
                    self.imageView.frame = CGRect(origin: .zero, size: CGSize(width: 50, height: 50))
                } else {
                    self.imageView.frame = CGRect(origin: CGPoint(x: 10, y: 10), size: CGSize(width: 30, height: 30))
                }
            })

        }
    }
    
    func style(icon: String) {
        imageView.image = UIImage(named: icon)
    }    
}
