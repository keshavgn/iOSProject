//
//  MLChatBotViewController.swift
//  iOSProject
//
//  Created by Keshav on 28/07/18.
//  Copyright © 2018 Keshav. All rights reserved.
//

import UIKit
import ApiAI
import AVFoundation

class MLChatBotViewController: UIViewController {

    @IBOutlet weak var textLabel: UILabel!
    @IBOutlet weak var inputTextField: UITextField!
    @IBOutlet weak var sendButton: UIButton!
    
    let speechSynthesizer = AVSpeechSynthesizer()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        title = Localized.Chatbot.title
        sendButton.roundedCorders(borderColor: .lightGray, borderWidth: 0.7)
        sendButton.setTitle(Localized.Chatbot.sendButtonTitle, for: .normal)
    }
    

    @IBAction func sendMessageToChatBot(_ sender: Any) {
        let request = ApiAI.shared().textRequest()
        
        if let text = self.inputTextField.text, text != "" {
            request?.query = text
        } else {
            return
        }
        
        request?.setMappedCompletionBlockSuccess({ (request, response) in
            if let response = response as? AIResponse {
                if let textResponse = response.result.fulfillment.speech {
                    self.speechAndText(text: textResponse)
                }
                if let context = response.result.contexts {
                    print(context)
                }
            }
        }, failure: { (request, error) in
            print(error!)
        })
        ApiAI.shared().enqueue(request)
        inputTextField.text = ""
    }
    
    
    private func speechAndText(text: String) {
        let speechUtterance = AVSpeechUtterance(string: text)
        speechSynthesizer.speak(speechUtterance)
        UIView.animate(withDuration: 1.0, delay: 0.0, options: .curveEaseInOut, animations: {
            self.textLabel.text = text
        }, completion: nil)
    }

}
