//
//  EventAttributes.swift
//  IngresseSDK
//
//  Created by Rubens Gondek on 9/20/17.
//  Copyright © 2017 Ingresse. All rights reserved.
//

public class EventAttributes: NSObject, Codable {
    public var accepted_apps: [String] = []
    public var ticket_transfer_enabled: Bool = true
    public var ticket_transfer_required: Bool = false

    public func applyJSON(_ json: [String: Any]) {
        accepted_apps = json["accepted_apps"] as? [String] ?? []
        ticket_transfer_enabled = json["ticket_transfer_enabled"] as? Bool ?? true
        ticket_transfer_required = json["ticket_transfer_required"] as? Bool ?? false
    }
}
