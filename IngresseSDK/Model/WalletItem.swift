//
//  WalletItem.swift
//  IngresseSDK
//
//  Created by Rubens Gondek on 7/19/17.
//  Copyright © 2017 Ingresse. All rights reserved.
//

public class WalletItem: JSONConvertible {
    public var id: Int = -1
    public var ownerId: Int = -1
    public var title: String = ""
    public var link: String = ""
    public var type: String = ""
    public var poster: String = ""
    public var eventDescription: String = ""
    public var tickets: Int = 0
    public var transfered: Int = 0
    public var sessions: [Session] = []
    public var sessionList: [Session] = []
    public var customTickets: [CustomTicket] = []
    public var venue: Venue = Venue()
    
    public override func applyJSON(_ json: [String : Any]) {
        for (key,value) in json {
            if key == "description" {
                applyKey("eventDescription", value: value)
                continue
            }
            
            if key == "sessions" || key == "sessionList" {
                self.applyArray(key: key, value: value, of: Session.self)
                continue
            }

            if key == "customTickets" {
                self.applyArray(key: key, value: value, of: CustomTicket.self)
                continue
            }
            
            if key == "venue" {
                guard let obj = value as? [String:Any] else { continue }
                self.venue.applyJSON(obj)
                continue
            }
            
            applyKey(key, value: value)
        }
    }
}
