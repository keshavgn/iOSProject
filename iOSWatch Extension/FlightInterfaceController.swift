//
//  FlightInterfaceController.swift
//  iOSWatch Extension
//
//  Created by Keshav on 12/03/18.
//  Copyright © 2018 Keshav. All rights reserved.
//

import WatchKit
import Foundation


class FlightInterfaceController: WKInterfaceController {
    @IBOutlet var flightLabel: WKInterfaceLabel!
    @IBOutlet var routeLabel: WKInterfaceLabel!
    @IBOutlet var boardingLabel: WKInterfaceLabel!
    @IBOutlet var boardTimeLabel: WKInterfaceLabel!
    @IBOutlet var statusLabel: WKInterfaceLabel!
    @IBOutlet var gateLabel: WKInterfaceLabel!
    @IBOutlet var seatLabel: WKInterfaceLabel!
    
    var flight: FlightDetail? {
        didSet {
            guard let flight = flight else { return }
            flightLabel.setText("Flight \(flight.shortNumber)")
            routeLabel.setText(flight.route)
            boardingLabel.setText("\(flight.number) Boards")
            boardTimeLabel.setText(flight.boardsAt)
            
            if flight.onSchedule {
                statusLabel.setText("On Time")
            } else {
                statusLabel.setText("Delayed")
                statusLabel.setTextColor(.red)
            }
            gateLabel.setText("Gate \(flight.gate)")
            seatLabel.setText("Seat \(flight.seat)")
        }
    }
    
    override func awake(withContext context: Any?) {
        super.awake(withContext: context)
        
        if let flight = context as? FlightDetail {
            self.flight = flight
        }
    }

    override func willActivate() {
        // This method is called when watch view controller is about to be visible to user
        super.willActivate()
    }

    override func didDeactivate() {
        // This method is called when watch view controller is no longer visible
        super.didDeactivate()
    }

}
