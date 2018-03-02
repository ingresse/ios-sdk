//
//  EventAttributes.swift
//  IngresseSDK
//
//  Created by Rubens Gondek on 9/20/17.
//  Copyright © 2017 Ingresse. All rights reserved.
//

public class EventAttributes: Codable {
    public var accepted_apps: [String] = []
    public var ticket_transfer_enabled: Bool = true
    public var ticket_transfer_required: Bool = false
}
