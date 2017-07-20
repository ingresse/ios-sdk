//
//  WalletItem.swift
//  IngresseSDK
//
//  Created by Rubens Gondek on 7/19/17.
//  Copyright © 2017 Ingresse. All rights reserved.
//

import Foundation

public class WalletItem: JSONConvertible {
    public var tickets: Int = 0
    public var transfered: Int = 0
    public var session: Session = Session()
    public var event: Event = Event()
    public var venue: Venue = Venue()
    
    public override func applyJSON(_ json: [String : Any]) {
        for key:String in json.keys {
            
            if ["session", "event", "venue"].contains(key) {
                guard let obj = json[key] as? [String:Any] else { continue }
                
                switch key {
                case "session":
                    self.session.applyJSON(obj)
                case "event":
                    self.event.applyJSON(obj)
                case "venue":
                    self.venue.applyJSON(obj)
                default:
                    continue
                }
                
                continue
            }
            
            applyKey(key, json: json)
        }
    }
}
