//
//  TodayViewController.swift
//  iOSToday
//
//  Created by Keshav on 27/03/18.
//  Copyright © 2018 Keshav. All rights reserved.
//

import UIKit
import NotificationCenter

class TodayViewController: UIViewController, NCWidgetProviding {
        
    @IBOutlet weak var titleLabel: UILabel!
    @IBOutlet weak var descriptionLabel: UILabel!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        titleLabel.text = "Today:"
        descriptionLabel.text = Date().toString()
        extensionContext?.widgetLargestAvailableDisplayMode = .expanded
    }
    
    override func viewDidLayoutSubviews() {
        if extensionContext?.widgetActiveDisplayMode == .expanded {
            descriptionLabel.text = Date().toString(dateFormat: "dd-MMM-yyyy HH:MM:SS")
        } else {
            descriptionLabel.text = Date().toString()
        }
    }
    
    func widgetActiveDisplayModeDidChange(_ activeDisplayMode: NCWidgetDisplayMode, withMaximumSize maxSize: CGSize) {
        let expanded = activeDisplayMode == .expanded
        preferredContentSize = expanded ? CGSize(width: maxSize.width, height: 200) : maxSize
    }
        
    func widgetPerformUpdate(completionHandler: (@escaping (NCUpdateResult) -> Void)) {
        // Perform any setup necessary in order to update the view.
        
        // If an error is encountered, use NCUpdateResult.Failed
        // If there's no update required, use NCUpdateResult.NoData
        // If there's an update, use NCUpdateResult.NewData
        
        completionHandler(NCUpdateResult.newData)
    }
    
}
