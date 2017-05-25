//
//  JSONConvertible.swift
//  IngresseSDK
//
//  Created by Rubens Gondek on 5/12/17.
//  Copyright © 2017 Ingresse. All rights reserved.
//

import UIKit

public class JSONConvertible: NSObject {
    
    func applyJSON(_ json: [String:Any]) {
        for key:String in json.keys {
            
            if !self.responds(to: NSSelectorFromString(key)) {
                continue
            }
            
            let value = (json[key] is String ? (json[key] as? String)?.trim() : json[key])
            
            if (value is NSNull || value == nil) {
                continue
            }
            
            self.setValue(value, forKey: key)
        }
    }
}
