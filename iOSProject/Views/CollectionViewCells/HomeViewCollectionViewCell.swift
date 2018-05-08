//
//  HomeViewCollectionViewCell.swift
//  iOSProject
//
//  Created by Keshav on 26/02/18.
//  Copyright © 2018 Keshav. All rights reserved.
//

import UIKit

final class HomeViewCollectionViewCell: UICollectionViewCell, Cardable, Identifiable {
    
    @IBOutlet weak var titleLabel: UILabel!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }
    
    override func layoutSubviews() {
        super.layoutSubviews()
        layoutCard()
    }
    
    func style(title: String) {
        titleLabel.text = title
    }

}
