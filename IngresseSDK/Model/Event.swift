//
//  Event.swift
//  IngresseSDK
//
//  Created by Rubens Gondek on 1/20/17.
//  Copyright © 2017 Gondek. All rights reserved.
//

public class Event: JSONConvertible {
    public var id: Int = 0
    public var title: String = ""
    public var link: String = ""
    public var type: String = ""
    public var poster: String = ""
    public var status: String = ""
    public var rsvpTotal: Int = 0
    public var saleEnabled: Bool = false
    public var eventDescription: String = ""
    public var rsvp: [User] = []
    public var date: [EventDate] = []
    public var venue: Venue = Venue()
    
    public override func applyJSON(_ json: [String : Any]) {
        for (key,value) in json {
            switch key {
            case "venue":
                guard let obj = value as? [String:Any] else { continue }
                self.venue.applyJSON(obj)
            case "rsvp":
                applyArray(key: key, value: value, of: User.self)
            case "date":
                applyArray(key: key, value: value, of: EventDate.self)
            case "description":
                applyKey("eventDescription", value: value)
            default:
                applyKey(key, value: value)
            }
        }
    }
}
