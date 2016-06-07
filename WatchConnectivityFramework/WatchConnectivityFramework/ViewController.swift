//
//  ViewController.swift
//  WatchConnectivityFramework
//
//  Created by Kaushik Shanmugam on 03/06/16.
//  Copyright © 2016 Kaushik Shanmugam. All rights reserved.
//

import UIKit
import WatchConnectivity

class ViewController: UIViewController, WCSessionDelegate {
    var session:WCSession!
    

    @IBOutlet weak var messageLabel: UILabel!
    override func viewDidLoad() {
        if (WCSession.isSupported()){
            self.session = WCSession.defaultSession()
            self.session.delegate = self
            self.session.activateSession()
        }
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
    }

    @IBAction func sendmessagetoWatch(sender: AnyObject) {
        //Send message to Watch
        
        session.sendMessage(["a":"Hello"], replyHandler: nil, errorHandler: nil)
    }
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    func session(session: WCSession, didReceiveMessage message: [String : AnyObject]) {
        // Receive message from Watch
        self.messageLabel.text = message["b"]! as? String
    }


}

