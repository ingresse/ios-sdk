//
//  EventAttributes.swift
//  IngresseSDK
//
//  Created by Rubens Gondek on 9/20/17.
//  Copyright © 2017 Ingresse. All rights reserved.
//

public class EventAttributes: JSONConvertible {
    public var acceptedApps: [String] = []
    public var ticketTransferEnabled: Bool = true
    public var ticketTransferRequired: Bool = false
    
    public override func applyJSON(_ json: [String : Any]) {
        for (key,value) in json {
            
            if key == "accepted_apps" {
                guard let apps = value as? [String] else { continue }
                self.acceptedApps = apps
                continue
            }
            
            if key == "ticket_transfer_enabled" {
                guard let enabled = value as? Bool else { continue }
                self.ticketTransferEnabled = enabled
                continue
            }
            
            if key == "ticket_transfer_required" {
                guard let required = value as? Bool else { continue }
                self.ticketTransferEnabled = required
                continue
            }
            
            applyKey(key, value: value)
        }
    }
}
