//
//  PeekToViewController.swift
//  iOSProject
//
//  Created by Keshav on 24/07/18.
//  Copyright © 2018 Keshav. All rights reserved.
//

import UIKit

class PeekToViewController: UIViewController {

    lazy var imageView: UIImageView = {
       let imageView = UIImageView()
        return imageView
    }()
    
    override func viewDidLoad() {
        super.viewDidLoad()

        view.iOS_addSubview(imageView)
    }
    
    func setImage(_ name: String) {
        imageView.image = UIImage(named: name)
    }
    
    override var previewActionItems: [UIPreviewActionItem] {
        let likeAction = UIPreviewAction(title: "Like", style: .default) { (action, viewController) -> Void in
        }
        
        let deleteAction = UIPreviewAction(title: "Delete", style: .destructive) { (action, viewController) -> Void in
        }
        return [likeAction, deleteAction]
    }

}
