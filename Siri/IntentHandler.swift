//
//  IntentHandler.swift
//  Siri
//
//  Created by Keshav on 16/07/18.
//  Copyright © 2018 Keshav. All rights reserved.
//

import Intents

class IntentHandler: INExtension {
    
    override func handler(for intent: INIntent) -> Any {
        guard intent is PhotoOfTheDayIntent else {
            fatalError("Unhandled intent type: \(intent)")
        }
        
        return PhotoOfTheDayIntentHandler()
    }
    
    
}
