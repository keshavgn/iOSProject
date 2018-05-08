//
//  StoryBoard+iOS.swift
//  iOSProject
//
//  Created by Keshav on 01/04/18.
//  Copyright © 2018 Keshav. All rights reserved.
//

import UIKit

extension UIStoryboard {
    
    class func iOS_storyboardWithName(_ boardName: String) -> UIStoryboard {
        return UIStoryboard(name: boardName, bundle: nil)
    }
    
    class var iOS_MainStoryBoard: UIStoryboard {
        return iOS_storyboardWithName("Main")
    }
    
    class var iOS_ContactDetailsViewController: ContactDetailsViewController? {
        return iOS_MainStoryBoard.instantiateViewController(withIdentifier: "ContactDetailsViewController") as? ContactDetailsViewController
    }
}
