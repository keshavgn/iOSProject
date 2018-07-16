//
//  PageViewCollectionViewCell.swift
//  iOSProject
//
//  Created by Keshav on 15/07/18.
//  Copyright © 2018 Keshav. All rights reserved.
//

import UIKit

class PageViewCollectionViewCell: UICollectionViewCell, Cardable, Identifiable {

    @IBOutlet weak var imageView: UIImageView!
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }
    
    override func layoutSubviews() {
        super.layoutSubviews()
        layoutCard()
    }

    func style(icon: String) {
        imageView.image = UIImage(named: icon)
    }

}
