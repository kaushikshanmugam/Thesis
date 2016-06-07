//
//  InterfaceController.swift
//  Communication_counter Extension
//
//  Created by Kaushik Shanmugam on 03/06/16.
//  Copyright © 2016 Kaushik Shanmugam. All rights reserved.
//

import WatchKit
import Foundation
import WatchConnectivity


class InterfaceController: WKInterfaceController, WCSessionDelegate {
    
    @IBOutlet var labelTimer: WKInterfaceLabel!
    //Communication session
    
    let session = WCSession.defaultSession()
    var watchCounter = 0

    @IBOutlet var label: WKInterfaceLabel!
    
    
    override func awakeWithContext(context: AnyObject?) {
        super.awakeWithContext(context)
        
        // Configure interface objects here.
    }

   
    override func willActivate() {
        // This method is called when watch view controller is about to be visible to user
        super.willActivate()
        initWCSession()
    }
    
    func initWCSession(){
        session.delegate = self
        session.activateSession()
    }
    
    func session(session: WCSession, didReceiveMessage message: [String : AnyObject]) {
        let msg = message["CounterValueFromiphone"]as! Int
        label.setText("Counter: \(msg)")
    }
    
    @IBAction func SendDataToPhone() {
        //Send data to iPhone
        let msg = ["CounterValueFromWatch" : watchCounter++]
        let start = NSDate()
        session.sendMessage(msg, replyHandler: {(replay) -> Void in
            let end = NSDate()
            let timeInterval:Double = end.timeIntervalSinceDate(start)
            //Display time interval
            self.labelTimer.setText("Time: \(timeInterval)")
            print(timeInterval)
            
            })
            
        {(error) -> Void in
            let end = NSDate()
            let timeInterval: Double = end.timeIntervalSinceDate(start)
            //Display time interval
            self.labelTimer.setText("Time:\(timeInterval)")
            print(timeInterval)
        }
        
        
    }

    override func didDeactivate() {
        // This method is called when watch view controller is no longer visible
        super.didDeactivate()
    }

}
