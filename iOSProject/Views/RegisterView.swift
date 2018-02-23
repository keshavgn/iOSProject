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

class RegisterView: UIView, Cardable {
    var maskedCarner: CACornerMask = [.layerMinXMinYCorner,.layerMaxXMinYCorner]
    var delegate: RegisterUserDelegate?

    @IBOutlet weak var emailTextField: UITextField!
    @IBOutlet weak var passwordTextField: UITextField!
    @IBOutlet weak var upArrowImageView: UIImageView!
    @IBOutlet weak var closeButton: UIButton!
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
    
    @IBAction func closeButtonAction(_ sender: Any) {
        delegate?.hideRegisterView()
    }
    
    func showOrHideSubViews(show: Bool) {
        closeButton.isHidden = !show
        upArrowImageView.isHidden = show
        spaceView.isHidden = !show
        
        UIView.animate(withDuration: 0.6, animations: {
            self.closeButton.alpha = show ? 1 : 0
            self.upArrowImageView.alpha = !show ? 0.4 : 0
        })
    }
    
    override func layoutSubviews() {
        layoutCard()
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
