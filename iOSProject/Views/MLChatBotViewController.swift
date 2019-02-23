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
        guard let text = self.inputTextField.text, text != "" else { return }
        let request = ApiAI.shared().textRequest()
        request?.query = text

        request?.setMappedCompletionBlockSuccess({ [weak self] (request, response) in
            guard let weakSelf = self, let response = response as? AIResponse else { return }
            if let textResponse = response.result.fulfillment.messages.first, var speech = textResponse["speech"] as? String {
                if speech.contains("[end]") {
                    speech = speech.replacingOccurrences(of: "[end]", with: "")
                    weakSelf.updateFinalStatus()
                }
                weakSelf.speechAndText(text: speech)
            }
        }, failure: { (request, error) in
            print(error!)
        })
        ApiAI.shared().enqueue(request)
        inputTextField.text = ""
    }
    
    private func updateFinalStatus() {
        sendButton.isHidden = true
        inputTextField.resignFirstResponder()
        inputTextField.isEnabled = false
        textLabel.font = UIFont.boldSystemFont(ofSize: 18)
        textLabel.textColor = .green
    }
    
    private func speechAndText(text: String) {
        let speechUtterance = AVSpeechUtterance(string: text)
        speechSynthesizer.speak(speechUtterance)
        UIView.animate(withDuration: 1.0, delay: 0.0, options: .curveEaseInOut, animations: {
            self.textLabel.text = text
        }, completion: nil)
    }

}
