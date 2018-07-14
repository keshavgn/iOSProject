//
//  ContactsListViewController.swift
//  iOSProject
//
//  Created by Keshav on 13/02/18.
//  Copyright © 2018 Keshav. All rights reserved.
//

import UIKit
import Firebase
import MobileCoreServices

final class ContactsListViewController: BaseViewController {

    private struct Constant {
        static let addContactSegueId = "AddContactSegueId"
        static let sectionHeaderHeight: CGFloat = 5
        static let estimatedRowHeight: CGFloat = 150
        static let cardEdgeInsets = UIEdgeInsets(top: 4, left: 12, bottom: 4, right: 12)
        static let contentEdgeInsets = UIEdgeInsets(top: 4, left: 16, bottom: 4, right: 16)
    }
    
    private let viewModel = ContactsViewModel()
    private let interactor = Interactor()
    lazy private var alertView: CustomAlertView = {
        let alertView = CustomAlertView()
        alertView.delegate = self
        return alertView
    }()

    lazy private var tableView: UITableView = {
        let tableView = UITableView()
        tableView.separatorColor = UIColor.clear
        tableView.rowHeight = UITableView.automaticDimension
        tableView.sectionHeaderHeight = Constant.sectionHeaderHeight
        tableView.estimatedRowHeight = Constant.estimatedRowHeight
        tableView.tableFooterView = UIView()
        tableView.delegate = self
        tableView.dataSource = self
        tableView.dragDelegate = self
        tableView.separatorStyle = .none
        tableView.dragInteractionEnabled = true
        return tableView
    }()
    
    lazy private var itemDropView: UIView = {
        let dropView = UIView()
        dropView.backgroundColor = UIColor.lightGray
        return dropView
    }()
    
    lazy private var deleteImageView: UIImageView = {
       let imageView = UIImageView()
        imageView.image = Asset.trashBin.image
        return imageView
    }()
        
    override func viewDidLoad() {
        super.viewDidLoad()

        title = Localized.contactsScreenTitle
        navigationItem.leftBarButtonItem = UIBarButtonItem(title: "Logout", style: .done, target: self, action: #selector(userLogout))
        navigationItem.rightBarButtonItem = UIBarButtonItem(barButtonSystemItem: .add, target: self, action: #selector(showAddContactView))
        setupUI()
    }
    
    private func setupUI() {
        view.iOS_addSubview(alertView, margin: .zero)
        
        view.iOS_addSubview(tableView, margin: .zero)
        viewModel.registerCellIdentifiers(to: tableView)
        viewModel.fetchContactListFromFirebase(completion:{ [weak self] success in
            if let weakSelf = self {
                weakSelf.tableView.reloadData()
            }
        })
        view.iOS_addSubviewWithFixedSize(itemDropView, maximumSubViewHeight: 80, onLayoutMargin: [.left, .right, .bottom])
        let dropInteraction = UIDropInteraction(delegate: self)
        itemDropView.addInteraction(dropInteraction)
        itemDropView.iOS_centerSubview(deleteImageView, width: 40, height: 50)
        showDropItemView(show: false)
    }
    
    private func showDropItemView(show: Bool) {
        itemDropView.isHidden = !show
    }
    
    private func showContactDetailView(index: Int) {
        if let contactDetailsViewController = UIStoryboard.iOS_ContactDetailsViewController {
            contactDetailsViewController.transitioningDelegate = self
            contactDetailsViewController.interactor = interactor
            contactDetailsViewController.modalPresentationStyle = .custom
            contactDetailsViewController.contact = viewModel.contactItem(at: index)
            present(contactDetailsViewController, animated: true, completion: nil)
        }
    }
    
    @objc private func userLogout() {
        UserViewModel.logoutUser()
        dismiss(animated: true, completion: nil)
    }
}

extension ContactsListViewController {
    @objc private func showAddContactView() {
        performSegue(withIdentifier: Constant.addContactSegueId, sender: nil)
    }
}

extension ContactsListViewController: UITableViewDataSource, UITableViewDelegate {
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return viewModel.numberOfItems
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        if let cell = tableView.dequeueReusableCell(withIdentifier: ContactListTableViewCell.identifier) as? ContactListTableViewCell {
            let contactItem = viewModel.contactItem(at: indexPath.row)
            cell.style(with: contactItem)
            cell.position = CardViewLayer.CardViewPosition(row: indexPath.row, numberOfRows: viewModel.numberOfItems)
            cell.cardEdgeInsets = Constant.cardEdgeInsets
            cell.contentEdgeInsets = Constant.contentEdgeInsets
            return cell
        }
        return UITableViewCell()
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        tableView.deselectRow(at: indexPath, animated: false)
        showContactDetailView(index: indexPath.row)
    }
}

extension ContactsListViewController: UITableViewDragDelegate, UIDropInteractionDelegate {
    func tableView(_ tableView: UITableView, dragSessionWillBegin session: UIDragSession) {
        showDropItemView(show: true)
    }
    
    func tableView(_ tableView: UITableView, dragSessionDidEnd session: UIDragSession) {
        showDropItemView(show: false)
    }
    
    func tableView(_ tableView: UITableView, itemsForBeginning session: UIDragSession, at indexPath: IndexPath) -> [UIDragItem] {
        return viewModel.dragItems(for: indexPath)
    }
    
    func tableView(_ tableView: UITableView, canHandle session: UIDropSession) -> Bool {
        return viewModel.canHandle(session)
    }
    
    func dropInteraction(_ interaction: UIDropInteraction, canHandle session: UIDropSession) -> Bool {
        return session.hasItemsConforming(toTypeIdentifiers: [kUTTypePlainText as String]) && session.items.count == 1
    }
    
    func dropInteraction(_ interaction: UIDropInteraction, sessionDidUpdate session: UIDropSession) -> UIDropProposal {
        let dropLocation = session.location(in: view)
        
        let operation: UIDropOperation
        
        if itemDropView.frame.contains(dropLocation) {
            operation = session.localDragSession == nil ? .copy : .move
        } else {
            operation = .cancel
        }
        
        return UIDropProposal(operation: operation)
    }
    
    func dropInteraction(_ interaction: UIDropInteraction, performDrop session: UIDropSession) {
        session.loadObjects(ofClass: NSString.self) { [weak self] items in
            if let weakSelf = self {
                let stringItems = items as! [String]
                for index in stringItems {
                    if let row = Int(index) {
                        weakSelf.alertView.tag = row
                        weakSelf.alertView.udpateTitle(title: Localized.alertDeleteContactTitle)
                        weakSelf.alertView.udpateDescription(description: Localized.alertDeleteContactDescription)
                    }
                }
            }
        }
    }
}

extension ContactsListViewController: CustomAlertViewDelegate {
    func didTapCancelButton() {
        alertView.isHidden = false
    }
    
    func didTapDoneButton() {
        viewModel.deleteContact(at: alertView.tag)
    }
}

extension ContactsListViewController: UIViewControllerTransitioningDelegate {
    func animationControllerForDismissedController(dismissed: UIViewController) -> UIViewControllerAnimatedTransitioning? {
        return DismissAnimator()
    }
    
    func interactionControllerForDismissal(using animator: UIViewControllerAnimatedTransitioning) -> UIViewControllerInteractiveTransitioning? {
        return interactor.hasStarted ? interactor : nil
    }
}

