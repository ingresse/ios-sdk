//
//  PendingTransfer.swift
//  IngresseSDK
//
//  Created by Rubens Gondek on 9/20/17.
//  Copyright © 2017 Ingresse. All rights reserved.
//

public class PendingTransfer: JSONConvertible {
    public var id: Int = 0
    public var event: Event = Event()
    public var venue: Venue = Venue()
    public var session: Session = Session()
    public var ticket: TransferTicket = TransferTicket()
    public var receivedFrom: Transfer = Transfer()
    
    public override func applyJSON(_ json: [String : Any]) {
        for (key,value) in json {
            if ["event", "venue", "session", "ticket", "receivedFrom"].contains(key) {
                guard let obj = value as? [String:Any] else { continue }
                
                switch key {
                case "event": self.event.applyJSON(obj)
                case "venue": self.venue.applyJSON(obj)
                case "session": self.session.applyJSON(obj)
                case "ticket": self.ticket.applyJSON(obj)
                case "receivedFrom": self.receivedFrom.applyJSON(obj)
                default: break
                }
                
                continue
            }
            
            applyKey(key, value: value)
        }
    }
}
