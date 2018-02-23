//
//  HomeViewController.swift
//  iOSProject
//
//  Created by Keshav on 13/02/18.
//  Copyright © 2018 Keshav. All rights reserved.
//

import UIKit
import Firebase


class HomeViewController: UIViewController {

    let viewModel = ContactsViewModel()
    
    private var tableView: UITableView = {
        let tableView = UITableView()
        tableView.separatorColor = UIColor.clear
        tableView.rowHeight = UITableViewAutomaticDimension
        tableView.sectionHeaderHeight = 5
        tableView.estimatedRowHeight = 150
        tableView.tableFooterView = UIView()
        return tableView
    }()
    
    override func viewDidLoad() {
        super.viewDidLoad()

        title = "Contacts"
        navigationItem.rightBarButtonItem = UIBarButtonItem(barButtonSystemItem: .add, target: self, action: #selector(showAddContactView))
        
        let alertView = CustomAlertView()
        alertView.udpateTitle(title: "Alert Title")
        alertView.udpateDescription(description: " error description to show to user")
        view.iOS_addSubview(alertView, margin: .zero)
        alertView.isHidden = true
        
        tableView.delegate = self
        tableView.dataSource = self
        tableView.separatorStyle = .none
        view.iOS_addSubview(tableView, margin: .zero)
        viewModel.registerCellIdentifiers(to: tableView)
        viewModel.fetchContactListFromFirebase(completion:{ [weak self] success in
            if let weakSelf = self {
                weakSelf.tableView.reloadData()
            }
        })
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
}

extension HomeViewController {
    @objc private func showAddContactView() {
        performSegue(withIdentifier: "AddContactSegueId", sender: nil)
    }
}

extension HomeViewController: UITableViewDataSource, UITableViewDelegate {
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return viewModel.numberOfItems
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        if let cell = tableView.dequeueReusableCell(withIdentifier: HomeViewTableViewCell.identifier) as? HomeViewTableViewCell {
            let contactItem = viewModel.contactItem(at: indexPath.row)
            cell.style(with: contactItem)
            return cell
        }
        return UITableViewCell()
    }
}


