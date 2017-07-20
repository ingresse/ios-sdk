//
//  JSONConvertible.swift
//  IngresseSDK
//
//  Created by Rubens Gondek on 5/12/17.
//  Copyright © 2017 Ingresse. All rights reserved.
//

public class JSONConvertible: NSObject {
    
    public func applyJSON(_ json: [String:Any]) {
        for key:String in json.keys {
            applyKey(key, json: json)
        }
    }
    
    public func applyKey(_ key: String, json: [String:Any]) {
        guard
            self.responds(to: NSSelectorFromString(key)),
            var value = json[key],
            !(value is NSNull)
            else { return }
        
        if let str = value as? String { value = str.trim() }
        
        self.setValue(value, forKey: key)
    }
}
