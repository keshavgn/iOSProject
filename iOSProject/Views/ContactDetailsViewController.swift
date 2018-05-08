//
//  ContactDetailsViewController.swift
//  iOSProject
//
//  Created by Keshav on 31/03/18.
//  Copyright © 2018 Keshav. All rights reserved.
//

import UIKit

class ContactDetailsViewController: UIViewController {
    @IBOutlet weak var nameLabel: UILabel!
    @IBOutlet weak var addressLabel: UILabel!
    @IBOutlet weak var phoneNumberLabel: UILabel!
    var initialTouchPoint: CGPoint = CGPoint(x: 0,y: 0)
    var interactor:Interactor? = nil
    var contact: ContactItem?

    override func viewDidLoad() {
        super.viewDidLoad()

        if let contact = contact {
            nameLabel.text = contact.name
            addressLabel.text = contact.address
            phoneNumberLabel.text = contact.phoneNumber
        }
        let panGestureRed = UIPanGestureRecognizer()
        panGestureRed.addTarget(self, action: #selector(panGestureRecognizerHandler(_:)))
        view.addGestureRecognizer(panGestureRed)
        
        if let activity = contact?.userActivity {
            switch Setting.searchIndexingPreference {
            case .Disabled:
                activity.isEligibleForSearch = false
            case .ViewedRecords:
                activity.isEligibleForSearch = true
            }
            activity.isEligibleForSearch = true
            userActivity = activity
        }
    }
    
    override func updateUserActivityState(_ activity: NSUserActivity) {
        if let userActivityUserInfo = contact?.userActivityUserInfo {
            activity.addUserInfoEntries(from: userActivityUserInfo)
        }
    }
    
    @IBAction func panGestureRecognizerHandler(_ sender: UIPanGestureRecognizer) {
        let percentThreshold:CGFloat = 0.3
        let translation = sender.translation(in: view)
        let verticalMovement = translation.y / view.bounds.height
        let downwardMovement = fmaxf(Float(verticalMovement), 0.0)
        let downwardMovementPercent = fminf(downwardMovement, 1.0)
        let progress = CGFloat(downwardMovementPercent)
        
        guard let interactor = interactor else { return }
        
        switch sender.state {
        case .began:
            interactor.hasStarted = true
            dismiss(animated: true, completion: nil)
        case .changed:
            interactor.shouldFinish = progress > percentThreshold
            interactor.update(progress)
        case .cancelled:
            interactor.hasStarted = false
            interactor.cancel()
        case .ended:
            interactor.hasStarted = false
            interactor.shouldFinish ? interactor.finish() : interactor.cancel()
        default:
            break
        }
    }
}
