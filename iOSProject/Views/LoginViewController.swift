//
//  LoginViewController.swift
//  iOSProject
//
//  Created by Keshav on 13/02/18.
//  Copyright © 2018 Keshav. All rights reserved.
//


import UIKit
import Firebase
import FirebaseAuthUI
import FirebaseGoogleAuthUI
import FirebaseFacebookAuthUI
import FirebaseTwitterAuthUI
import FirebasePhoneAuthUI

final class LoginViewController: BaseViewController {
    
    struct Constant {
        static let RegisterBottomMargin: CGFloat = 120
        static let HomeViewSegue = "HomeViewSegue"
    }
    
    @IBOutlet weak var emailTextField: UITextField!
    @IBOutlet weak var passwordTextField: UITextField!
    @IBOutlet weak var registerViewTopConstraint: NSLayoutConstraint!
    @IBOutlet weak var registerView: RegisterView!
    
    var isShowingRegister = false
    let viewModel = UserViewModel()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        title = Localized.loginScreenTitle
        emailTextField.text = "keshavgn@gmail.com"
        passwordTextField.text = "aaaaaa"
        registerView.delegate = self
        registerViewTopConstraint.constant = view.frame.size.height - Constant.RegisterBottomMargin
        registerView.showOrHideSubViews(show: false)

    }
    
    @IBAction func nativeLogin(_ sender: Any) {
        viewModel.loginUser(email: emailTextField.text!, password: passwordTextField.text!, completion: { [weak self](success, message) in
            guard let weakSelf = self else { return }
            if success == true {
                weakSelf.performSegue(withIdentifier: Constant.HomeViewSegue, sender: nil)
            } else {
                weakSelf.showAlert(title: Localized.loginScreenLoginFail, message: message)
            }
        })
        
    }
    
    @IBAction func webLogin(_ sender: Any) {
        let authUI = FUIAuth.defaultAuthUI()
        authUI?.delegate = self
        let providers: [FUIAuthProvider] = [ FUIGoogleAuth(), FUIFacebookAuth(), FUITwitterAuth()]
        authUI?.providers = providers
        
        let authViewController = authUI!.authViewController()
        present(authViewController, animated: true, completion: nil)
    }
    
    
    private func showOrHideSubViews(show: Bool) {
        isShowingRegister = show
        registerView.showOrHideSubViews(show: show)
    }
}

extension LoginViewController: UITextFieldDelegate {
  
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

extension LoginViewController {
    
    private func animationView(completion: ((Bool)->(Void))?) {
        UIView.animate(withDuration: 1.0, delay: 0.0, usingSpringWithDamping: 0.5, initialSpringVelocity: 0.5, options: .curveEaseInOut, animations: {
            self.view.layoutIfNeeded()
        }, completion: { _ in
            completion?(true)
        })
    }
    
    override func touchesMoved(_ touches: Set<UITouch>, with event: UIEvent?) {
        if let touch = touches.first {
            let touchPoint = touch.location(in: self.view)
            registerViewTopConstraint.constant = touchPoint.y - 40
            animationView(completion: nil)
        }
    }
    
    override func touchesEnded(_ touches: Set<UITouch>, with event: UIEvent?) {
        updateRegisterView(touches: touches)
    }
    
    override func touchesCancelled(_ touches: Set<UITouch>, with event: UIEvent?) {
        updateRegisterView(touches: touches)
    }
    
    private func updateRegisterView(touches: Set<UITouch>) {
        if let touch = touches.first {
            let touchPoint = touch.location(in: self.view)
            if touchPoint.y < 400 {
                registerViewTopConstraint.constant = Constant.RegisterBottomMargin
                animationView(completion: { _ in
                    self.showOrHideSubViews(show: true)
                })
            } else {
                hideRegisterView()
            }
        }
    }
}

extension LoginViewController: FUIAuthDelegate, RegisterUserDelegate {
    
    func registerNewUser(email: String, password: String) {
        viewModel.registerNewUser(email: email, password: password, completion: { [weak self] (success, message) in
            guard let weakSelf = self else { return }
            if success == true {
                weakSelf.nativeLogin(weakSelf)
            } else {
                weakSelf.showAlert(title: Localized.loginScreenRegisterFail, message: message)
            }
        })
    }
    
    func hideRegisterView() {
        registerViewTopConstraint.constant = view.frame.size.height - Constant.RegisterBottomMargin
        animationView(completion: { _ in
            self.showOrHideSubViews(show: false)
        })
    }
    
    func authUI(_ authUI: FUIAuth, didSignInWith user: User?, error: Error?) {
        if let errors = error {
            print(errors)
        }
        if user != nil && error == nil {
            self.performSegue(withIdentifier: Constant.HomeViewSegue, sender: nil)
        }
    }
}

