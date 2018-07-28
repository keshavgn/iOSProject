//
//  ForgotPasswordViewController.swift
//  iOSProject
//
//  Created by Keshav on 14/04/18.
//  Copyright © 2018 Keshav. All rights reserved.
//

import UIKit

final class ForgotPasswordViewController: UIViewController {

    @IBOutlet weak var confirmationView: UIView!
    @IBOutlet weak var emailTextField: UITextField!
    
    override func viewDidLoad() {
        super.viewDidLoad()

        confirmationView.layer.cornerRadius = 8.0
        confirmationView.layer.borderColor = UIColor.lightGray.cgColor
        confirmationView.layer.borderWidth = 1
        confirmationView.isHidden = true
    }

    @IBAction func submit(_ sender: Any) {
        UserViewModel().forgotPassword(email: emailTextField.text!, completion: { [weak self] (success, message) in
            guard let weakSelf = self, success == true else { return }
            weakSelf.confirmationView.isHidden = false
            weakSelf.perform(#selector(weakSelf.dismiss(animated:completion:)), with: nil, afterDelay: 0.5)
        })
    }
}
