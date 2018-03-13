//
//  ScheduleInterfaceController.swift
//  iOSWatch Extension
//
//  Created by Keshav on 12/03/18.
//  Copyright © 2018 Keshav. All rights reserved.
//

import WatchKit
import Foundation


class ScheduleInterfaceController: WKInterfaceController {

    @IBOutlet var tableView: WKInterfaceTable!
    
    var flights = FlightDetail.allFlights()
    
    override func awake(withContext context: Any?) {
        super.awake(withContext: context)
        
        tableView.setNumberOfRows(flights.count, withRowType: "FlightRow")
        
        for index in 0..<tableView.numberOfRows {
            guard let controller = tableView.rowController(at: index) as? FlightRowGroup else { continue }
            controller.flight = flights[index]
        }
    }

    override func table(_ table: WKInterfaceTable, didSelectRowAt rowIndex: Int) {        
        let flight = flights[rowIndex]
        let controllers = ["Flight", "CheckIn"]
        presentController(withNames: controllers, contexts: [flight, flight])
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
