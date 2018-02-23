//
//  HomeViewTableViewCell.swift
//  iOSProject
//
//  Created by Keshav on 21/02/18.
//  Copyright © 2018 Keshav. All rights reserved.
//

import UIKit

class HomeViewTableViewCell: UITableViewCell {
    @IBOutlet weak var titleLabel: UILabel!
    @IBOutlet weak var addressLabel: UILabel!
    @IBOutlet weak var phoneNumberLabel: UILabel!
    
    static let identifier = "HomeViewTableViewCellIdentifier"
    override public func awakeFromNib() {
        super.awakeFromNib()
    }
    
    override func layoutSubviews() {
        super.layoutSubviews()
    }
    
    override func layoutMarginsDidChange() {
        super.layoutMarginsDidChange()
    }

    func style(with contactItem: ContactItem) {
        titleLabel.text = contactItem.name
        addressLabel.text = contactItem.address
        phoneNumberLabel.text = contactItem.phoneNumber
    }
}
