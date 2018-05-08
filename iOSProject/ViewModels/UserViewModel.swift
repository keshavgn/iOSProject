//
//  UserViewModel.swift
//  iOSProject
//
//  Created by Keshav on 18/02/18.
//  Copyright © 2018 Keshav. All rights reserved.
//

import Firebase
import FirebaseAuthUI
import FirebaseGoogleAuthUI
import FirebaseFacebookAuthUI
import FirebaseTwitterAuthUI
import FirebasePhoneAuthUI

final class UserViewModel {
    
    func registerNewUser(email: String, password: String, completion: @escaping ((Bool, String) -> Void)) {
        if !isValidEmail(email) {
            return completion(false, "Invalid email address")
        } else if isValidPassword(password) {
            return completion(false, "Invalid passwod\n Combination of least 1 small and 1 big, 1 digit, 1 special and minimum 8 letters")
        }
        Auth.auth().createUser(withEmail: email, password: password, completion: { (user: User, error: Error) in
            completion(true, "")
        } as? AuthResultCallback)
    }
    
    func loginUser(email: String, password: String, completion: @escaping ((Bool, String) -> Void)) {
        if !isValidEmail(email) {
            return completion(false, "Invalid email address")
        } else if isValidPassword(password) {
            return completion(false, "Invalid passwod\n Combination of least 1 small and 1 big, 1 digit, 1 special and minimum 8 letters")
        }
        Auth.auth().signIn(withEmail: email, password: password, completion: { (user: User?, error: Error?) in
            completion(error == nil, error?.localizedDescription ?? "")
        })
    }
    
    static func logoutUser() {
        do {
            try Auth.auth().signOut()
        } catch _ {}
    }
    
    func forgotPassword(email: String, completion: @escaping ((Bool, String) -> Void)) {
        if !isValidEmail(email) {
            return completion(false, "Invalid email address")
        }
        Auth.auth().sendPasswordReset(withEmail: email, completion: { (error: Error?) in
            completion(error == nil, error?.localizedDescription ?? "")
        })
    }
    
    func isValidEmail(_ email: String) -> Bool {
        let regex = "(?:[\\p{L}0-9!#$%\\&'*+/=?\\^_`{|}~-]+(?:\\.[\\p{L}0-9!#$%\\&'*+/=?\\^_`{|}" +
            "~-]+)*|\"(?:[\\x01-\\x08\\x0b\\x0c\\x0e-\\x1f\\x21\\x23-\\x5b\\x5d-\\" +
            "x7f]|\\\\[\\x01-\\x09\\x0b\\x0c\\x0e-\\x7f])*\")@(?:(?:[\\p{L}0-9](?:[a-" +
            "z0-9-]*[\\p{L}0-9])?\\.)+[\\p{L}0-9](?:[\\p{L}0-9-]*[\\p{L}0-9])?|\\[(?:(?:25[0-5" +
            "]|2[0-4][0-9]|[01]?[0-9][0-9]?)\\.){3}(?:25[0-5]|2[0-4][0-9]|[01]?[0-" +
            "9][0-9]?|[\\p{L}0-9-]*[\\p{L}0-9]:(?:[\\x01-\\x08\\x0b\\x0c\\x0e-\\x1f\\x21" +
        "-\\x5a\\x53-\\x7f]|\\\\[\\x01-\\x09\\x0b\\x0c\\x0e-\\x7f])+)\\])"
        let emailTest = NSPredicate(format:"SELF MATCHES[c] %@", regex)
        return emailTest.evaluate(with: email)
    }
    
    func isValidPassword(_ password: String) -> Bool {
        let passwordRegex = "^(?=.*\\d)(?=.*[a-z])(?=.*[A-Z])[0-9a-zA-Z!@#$%^&*()-_=+{}|?>.<,:;~`’]{8,}$"
        return NSPredicate(format: "SELF MATCHES %@", passwordRegex).evaluate(with: password)
    }
}
