//
//  InterfaceController.swift
//  Watch_Connectiviity Extension
//
//  Created by Kaushik Shanmugam on 03/06/16.
//  Copyright © 2016 Kaushik Shanmugam. All rights reserved.
//

import WatchKit
import Foundation
import WatchConnectivity


class InterfaceController: WKInterfaceController, WCSessionDelegate {
    
    

    @IBOutlet var messageLabel: WKInterfaceLabel!
    var session:WCSession!
    override func awakeWithContext(context: AnyObject?) {
        super.awakeWithContext(context)
        
        // Configure interface objects here.
    }
    

    override func willActivate() {
        // This method is called when watch view controller is about to be visible to user
        super.willActivate()
        if (WCSession.isSupported()){
            self.session = WCSession.defaultSession()
            self.session.delegate = self
            self.session.activateSession()
    }
    }
    override func didDeactivate() {
        // This method is called when watch view controller is no longer visible
        super.didDeactivate()
    }


    @IBAction func SendMessageToPhone() {
        
        if(WCSession.isSupported()){
            session.sendMessage(["b":"GoodBye"], replyHandler: nil, errorHandler: nil)
        }
    }
   

   

        func session(session: WCSession, didReceiveMessage message: [String : AnyObject]) {
            // Receiving message from iPhone
            self.messageLabel.setText(message["a"]! as? String)
    }
}