//
//  Event.swift
//  IngresseSDK
//
//  Created by Rubens Gondek on 1/20/17.
//  Copyright © 2017 Gondek. All rights reserved.
//

import Foundation

public class Event {
    public var id               : String
    public var name             : String
    public var link             : String
    public var type             : String
    public var poster           : String
    public var eventDescription : String
    public var venueId          : String
    public var venueCity        : String
    public var venueComplement  : String
    public var venueCountry     : String
    public var venueCrossStreet : String
    public var venueName        : String
    public var venueState       : String
    public var venueStreet      : String
    public var venueZipCode     : String
    public var venueHidden      : Bool
    public var latitude    : Double
    public var longitude   : Double
    
    init(withJSON json:[String:Any]) {
        let event = json["event"] as! [String:AnyObject]
        let venue = json["venue"] as! [String:AnyObject]
        
        let id = String(event["id"] as! Int)
        
        self.id = id
        self.name = event["title"] as! String
        self.link = event["link"] as! String
        self.type = event["type"] as! String
        self.poster = event["poster"] as! String
        self.eventDescription = event["description"] as! String
        
        self.venueId = String(venue["id"] as! Int)
        self.venueCity = venue["city"] as! String
        self.venueComplement = venue["complement"] as! String
        self.venueCountry = venue["country"] as! String
        self.venueCrossStreet = (venue["crossStreet"] as? String) ?? ""
        self.venueName = venue["name"] as! String
        self.venueState = venue["state"] as! String
        self.venueStreet = venue["street"] as! String
        self.venueZipCode = venue["zipCode"] as! String
        self.venueHidden = venue["hidden"] as! Bool
        self.latitude = venue["latitude"] as! Double
        self.longitude = venue["longitude"] as! Double
    }
    
    init() {
        self.id = ""
        self.name = ""
        self.link = ""
        self.type = ""
        self.poster = ""
        self.eventDescription = ""
        
        self.venueId = ""
        self.venueCity = ""
        self.venueComplement = ""
        self.venueCountry = ""
        self.venueCrossStreet = ""
        self.venueName = ""
        self.venueState = ""
        self.venueStreet = ""
        self.venueZipCode = ""
        self.venueHidden = false
        self.latitude = 0.0
        self.longitude = 0.0
    }
}
