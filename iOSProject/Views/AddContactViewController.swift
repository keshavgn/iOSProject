//
//  AddContactViewController.swift
//  iOSProject
//
//  Created by Keshav on 22/02/18.
//  Copyright © 2018 Keshav. All rights reserved.
//

import UIKit

class AddContactViewController: UITableViewController {

    @IBOutlet weak var nameTextField: UITextField!
    @IBOutlet weak var addressTextField: UITextField!
    @IBOutlet weak var phoneNumberTextField: UITextField!
    
    var viewModel = ContactsViewModel()
    
    override func viewDidLoad() {
        super.viewDidLoad()
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    @IBAction func saveContact(_ sender: Any) {
        if let name = nameTextField.text, let address = addressTextField.text, let phoneNo = phoneNumberTextField.text {
            viewModel.addContacts(name: name, address: address, phoneNumber: phoneNo)
            dismiss(animated: true, completion: nil)
        }
    }
    
    @IBAction func cancel(_ sender: Any) {
        dismiss(animated: true, completion: nil)
    }
    
}

extension AddContactViewController {
    func textRespondersForIndexPaths() -> NSDictionary {
        let indexPaths = NSMutableDictionary()
        indexPaths[0] = nameTextField
        indexPaths[1] = addressTextField
        indexPaths[2] = phoneNumberTextField
        return indexPaths
    }
}

extension AddContactViewController: UITextFieldDelegate {
    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        
        var returningIndexPath: Int?
        textRespondersForIndexPaths().enumerateKeysAndObjects({ (key, obj, stop) in
            if let currentTextField = obj as? UITextField {
                if (currentTextField == textField) {
                    returningIndexPath = key as? Int
                }
            }
        })
        
        return false
    }
}

