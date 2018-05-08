//
//  BaseViewController.swift
//  iOSProject
//
//  Created by Keshav on 14/04/18.
//  Copyright © 2018 Keshav. All rights reserved.
//

import UIKit

class BaseViewController: UIViewController {

    let alert = CustomAlertView()
    
    override func viewDidLoad() {
        super.viewDidLoad()

        view.iOS_addSubview(alert)
        alert.isHidden = true
    }
    
    func showAlert(title: String, message: String) {
        view.endEditing(true)
        alert.isHidden = false
        alert.udpateTitle(title: title)
        alert.udpateDescription(description: message)
    }
}
