//
//  EventAttributes.swift
//  IngresseSDK
//
//  Created by Rubens Gondek on 12/8/16.
//  Copyright © 2016 Gondek. All rights reserved.
//

import Foundation

class EventAttributes: NSObject {
    var acceptedApps : [String] = []
    var ticketTransferRequired : Bool = false
    var ticketTransferEnabled : Bool = true
    
    enum ConvertError: Error {
        case invalidFormat
    }
    
    func inputData(_ responseData: [String:Any]) throws {
        
        try self.validateArray(responseData["accepted_apps"] as AnyObject);
        try self.validateBool(responseData["ticket_transfer_enabled"] as AnyObject)
        try self.validateBool(responseData["ticket_transfer_required"] as AnyObject)
        
        if let apps = responseData["accepted_apps"] as? [String] {
            self.acceptedApps = apps
        }
        
        self.ticketTransferEnabled = responseData["ticket_transfer_enabled"] as! Bool
        self.ticketTransferRequired = responseData["ticket_transfer_required"] as! Bool
    }
    
    func validateArray(_ data:AnyObject) throws{
        if !data.isKind(of: NSArray.classForCoder()) && !data.isKind(of: NSNull.classForCoder()) {
            throw ConvertError.invalidFormat
        }
    }
    
    func validateBool(_ data:AnyObject) throws{
        if !(data is Bool) {
            throw ConvertError.invalidFormat
        }
    }
    
}

