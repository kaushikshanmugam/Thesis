//
//  ViewController.swift
//  WatchCommunication_counter
//
//  Created by Kaushik Shanmugam on 03/06/16.
//  Copyright © 2016 Kaushik Shanmugam. All rights reserved.
//

import UIKit
import WatchConnectivity
class ViewController: UIViewController, WCSessionDelegate{
    
    


    
    //Communication session
    
    let session = WCSession.defaultSession()
    var phoneCounter = 0

    @IBOutlet weak var labelcounter: UILabel!
    override func viewDidLoad() {
        super.viewDidLoad()
        initWCSession()
        // Do any additional setup after loading the view, typically from a nib.
    }
    
    @IBOutlet weak var timelabel: UILabel!
//    
//    func willActivate(){
//    [super.willActivate]
//    self.number = 0;
//    NSTimer *t = [NSTimer timerWithTimeInterval:0.1 target:self selector:@selector(updateLabelText) userInfo:nil repeats:YES];
//    NSRunLoop *runner = [NSRunLoop currentRunLoop];
//    [runner addTimer:t forMode: NSDefaultRunLoopMode];
//    }
//}
//
//func updateLabelText() {
//    NSString *str = [NSString stringWithFormat:@"number %ld", self.number];
//    [self.timelabel setText:str];
//    self.number += 1;
//}


    
    func initWCSession(){
        session.delegate = self
        session.activateSession()
    }
    
    func session(session: WCSession, didReceiveMessage message: [String : AnyObject]) {
        
        
        let msg = message["CounterValueFromWatch"]as! Int
        labelcounter.text = "Counter: \(msg)"
    }

    
    @IBAction func sendData(sender: AnyObject) {
        //Send data to apple watch
        
        let msg = ["CounterValueFromiphone" : phoneCounter++]
        let start  = NSDate()
    session.sendMessage(msg, replyHandler: {(replay) -> Void in
        let end = NSDate()
        let timeInterval: Double = end.timeIntervalSinceDate(start)
        //Display time interval in main queue
        self.timelabel.text = ("Time: \(timeInterval)")
        
        print (timeInterval)
        
    }) {(error) -> Void in
        let end = NSDate()
        let timeInterval: Double = end.timeIntervalSinceDate(start)
        //Display time interval in main queue
        self.timelabel.text = "Time: \(timeInterval)"
        print(timeInterval)
        
        }
    }
    
   
    
    
    }
    
   

