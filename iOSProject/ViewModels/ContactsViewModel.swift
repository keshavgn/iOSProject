//
//  ContactsViewModel.swift
//  iOSProject
//
//  Created by Keshav on 21/02/18.
//  Copyright © 2018 Keshav. All rights reserved.
//

import Firebase
import UIKit
import MobileCoreServices

final class ContactsViewModel {
    private let ref = Database.database().reference(withPath: "contacts")  //"auth != null"
    let addContactViewCellIdentifiers = ["NameCellId", "AddressCellId", "PhoneNumberCellId"]
    
    var contactItems: [ContactItem] = []
    var numberOfRows: Int {
        get {
            return addContactViewCellIdentifiers.count
        }
    }
    
    var numberOfItems: Int {
        get {
            return contactItems.count
        }
    }
    
    func contactItem(at index: Int) -> ContactItem {
        return contactItems[index]
    }

    
    func cellIdentifer(at index: Int) -> String {
        return addContactViewCellIdentifiers[index]
    }
    
    func addContacts(name: String, address: String, phoneNumber: String) {
        let contactItem = ContactItem(name: name, address: address, phoneNumber: phoneNumber)
        let contactItemRef = self.ref.child(name.lowercased())
        contactItemRef.setValue(contactItem.toAnyObject())
    }
    
    func deleteContact(at index: Int) {
        let contactItem = contactItems[index]
        contactItem.ref?.removeValue()
    }
    
    func updateContactDetails(at index: Int) {
        let contactItem = self.contactItem(at: index)
        contactItem.ref?.updateChildValues([
            "name": "Keshav"
            ])
    }

    func fetchContactListFromFirebase( completion: @escaping((Bool) -> Void)) {
        ref.observe(.value, with: { [weak self] snapshot in
            if let weakSelf = self {
                var items: [ContactItem] = []
                for item in snapshot.children {
                    let contactItem = ContactItem(snapshot: item as! DataSnapshot)
                    items.append(contactItem)
                }
                weakSelf.contactItems = items
            }
            completion(true)
        })
    }
    
    func registerCellIdentifiers(to tableView: UITableView) {
        tableView.register(UINib(nibName: ContactListTableViewCell.className, bundle: nil), forCellReuseIdentifier: ContactListTableViewCell.identifier)
    }
    
    func dragItems(for indexPath: IndexPath) -> [UIDragItem] {
        let contactName = "\(indexPath.row)"
        
        let data = contactName.data(using: .utf8)
        let itemProvider = NSItemProvider()
        
        itemProvider.registerDataRepresentation(forTypeIdentifier: kUTTypePlainText as String, visibility: .all) { completion in
            completion(data, nil)
            return nil
        }
        
        return [
            UIDragItem(itemProvider: itemProvider)
        ]
    }
    
    func canHandle(_ session: UIDropSession) -> Bool {
        return session.canLoadObjects(ofClass: NSString.self)
    }
}
