//
//  RegisterView.swift
//  iOSProject
//
//  Created by Keshav on 17/02/18.
//  Copyright © 2018 Keshav. All rights reserved.
//

import UIKit

protocol RegisterUserDelegate {
    func registerNewUser(email: String, password: String)
    func hideRegisterView()
}

final class RegisterView: UIView, Cardable {
    var delegate: RegisterUserDelegate?

    @IBOutlet weak var emailTextField: UITextField!
    @IBOutlet weak var passwordTextField: UITextField!
    @IBOutlet weak var upArrowImageView: UIImageView!
    @IBOutlet weak var spaceView: UIView!
    
    public override init(frame: CGRect) {
        super.init(frame: frame)
        commonInit()
    }
    
    required public init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
        commonInit()
    }

    private func commonInit() {
    }
    
    @IBAction func registerNewUser(_ sender: Any) {
        delegate?.registerNewUser(email: emailTextField.text!, password: passwordTextField.text!)
    }
        
    func showOrHideSubViews(show: Bool) {
        upArrowImageView.isHidden = show
        spaceView.isHidden = !show
        upArrowImageView.alpha = !show ? 0.4 : 0
    }
    
    override func layoutSubviews() {
        layoutCard()
    }
    
    func maskedCarner() -> CACornerMask {
        return [.layerMinXMinYCorner,.layerMaxXMinYCorner]
    }
}

extension RegisterView: UITextFieldDelegate {
    
    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        if textField == emailTextField {
            passwordTextField.becomeFirstResponder()
        }
        if textField == passwordTextField {
            textField.resignFirstResponder()
        }
        return true
    }
}
