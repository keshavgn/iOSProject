//
//  MachineLearningViewController.swift
//  iOSProject
//
//  Created by Keshav on 26/02/18.
//  Copyright © 2018 Keshav. All rights reserved.
//

import UIKit

final class MachineLearningViewController: UIViewController {

    @IBOutlet weak var imageRecognitionButton: UIButton!
    @IBOutlet weak var chatBotButton: UIButton!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        title = Localized.MlScreen.title
        imageRecognitionButton.roundedCorders(borderColor: .blue, borderWidth: 0.7)
        chatBotButton.roundedCorders(borderColor: .blue, borderWidth: 0.7)
    }
}
