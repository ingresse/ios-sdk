//
//  Session.swift
//  IngresseSDK
//
//  Created by Rubens Gondek on 1/20/17.
//  Copyright © 2016 Ingresse. All rights reserved.
//

import Foundation

public class Session {
    public var id         : String
    public var date       : String
    public var tickets    : Int
    public var transfered : Int
    public var dateTime   : Date
    public var event      : Event
    
    init(withJSON json:[String:Any]) {
        
        let session = json["session"] as! [String:AnyObject]
        
        let id = String(session["id"] as! Int)
        
        self.id         = id
        self.date       = DateHelper.stringFromTimeStamp(session["datetime"] as! String)
        self.dateTime   = DateHelper.dateFromTimeStamp(session["datetime"] as! String)
        self.tickets    = json["tickets"] as! Int
        self.transfered = json["transfered"] as! Int
        
        self.event = Event(withJSON: json)
    }
}

