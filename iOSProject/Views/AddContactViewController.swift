//
//  AddContactViewController.swift
//  iOSProject
//
//  Created by Keshav on 22/02/18.
//  Copyright © 2018 Keshav. All rights reserved.
//

import UIKit

final class AddContactViewController: UITableViewController {

    @IBOutlet weak var nameTextField: UITextField!
    @IBOutlet weak var addressTextField: UITextField!
    @IBOutlet weak var phoneNumberTextField: UITextField!
    
    private var viewModel = ContactsViewModel()
    private var sortedResponderIndexs = [Int]()
    private var currentIndex = 0
    private var leftBarButton = UIBarButtonItem()
    private var rightBarButton = UIBarButtonItem()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setupInputAccessoryToolbar()
    }

    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        nameTextField.becomeFirstResponder()
        sortedResponderIndexs = textRespondersForIndexPaths().allKeys as! [Int]
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
    private func textRespondersForIndexPaths() -> NSDictionary {
        let indexPaths = NSMutableDictionary()
        indexPaths[0] = nameTextField
        indexPaths[1] = addressTextField
        indexPaths[2] = phoneNumberTextField
        return indexPaths
    }
    
    private func setupInputAccessoryToolbar() {
        let toolbar = UIToolbar(frame: CGRect(x: 0, y: 0, width: view.frame.width, height: 44))
        leftBarButton = UIBarButtonItem(barButtonSystemItem: .rewind, target: self, action: #selector(previousField))
        let spaceButton = UIBarButtonItem(barButtonSystemItem: .flexibleSpace, target: nil, action: nil)
        rightBarButton = UIBarButtonItem(barButtonSystemItem: .fastForward, target: self, action: #selector(nextField))
        toolbar.items = [leftBarButton, spaceButton, rightBarButton]
        nameTextField.inputAccessoryView = toolbar
        addressTextField.inputAccessoryView = toolbar
        phoneNumberTextField.inputAccessoryView = toolbar
    }
    
    @objc private func previousField() {
        let index = sortedResponderIndexs[currentIndex]
        let previousIndex = max(0, index - 1)
        if previousIndex >= 0 {
            let indexPath = sortedResponderIndexs[previousIndex]
            let textField = textRespondersForIndexPaths()[indexPath] as? UITextField
            textField?.becomeFirstResponder()
            currentIndex = previousIndex
        }
    }
    
    @objc private func nextField() {
        let index = sortedResponderIndexs[currentIndex]
        let nextIndex = min(sortedResponderIndexs.count, index + 1)
        if nextIndex < sortedResponderIndexs.count {
            let indexPath = sortedResponderIndexs[nextIndex]
            let textField = textRespondersForIndexPaths()[indexPath] as? UITextField
            textField?.becomeFirstResponder()
            currentIndex = nextIndex
        }
    }
    
    private func updateResponderControls() {
        leftBarButton.isEnabled = currentIndex > 0
        rightBarButton.isEnabled = currentIndex < sortedResponderIndexs.count - 1
    }
}

extension AddContactViewController: UITextFieldDelegate {
    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        textRespondersForIndexPaths().enumerateKeysAndObjects({ (key, obj, stop) in
            if let currentTextField = obj as? UITextField {
                if (currentTextField == textField) {
                    currentIndex = key as! Int
                }
            }
        })
        return false
    }
    
    func textFieldDidBeginEditing(_ textField: UITextField) {
        textRespondersForIndexPaths().enumerateKeysAndObjects({ (key, obj, stop) in
            if let currentTextField = obj as? UITextField {
                if (currentTextField == textField) {
                    currentIndex = key as! Int
                }
            }
        })
        updateResponderControls()
    }
}

