//
//  FlightRowGroup.swift
//  iOSWatch Extension
//
//  Created by Keshav on 12/03/18.
//  Copyright © 2018 Keshav. All rights reserved.
//

import WatchKit

class FlightRowGroup: NSObject {
    @IBOutlet var separator: WKInterfaceSeparator!
    @IBOutlet var originLabel: WKInterfaceLabel!
    @IBOutlet var destinationLabel: WKInterfaceLabel!
    @IBOutlet var flightNumberLabel: WKInterfaceLabel!
    @IBOutlet var statusLabel: WKInterfaceLabel!
    @IBOutlet var planeImage: WKInterfaceImage!
    
    var flight: Flight? {
        didSet {
            guard let flight = flight else { return }

            originLabel.setText(flight.origin)
            destinationLabel.setText(flight.destination)
            flightNumberLabel.setText(flight.number)
            planeImage.setTintColor(UIColor.red)
            
            if flight.onSchedule {
                statusLabel.setText("On Time")
            } else {
                statusLabel.setText("Delayed")
                statusLabel.setTextColor(.red)
            }
        }
    }
}
