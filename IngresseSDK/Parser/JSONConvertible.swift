//
//  JSONConvertible.swift
//  IngresseSDK
//
//  Created by Rubens Gondek on 5/12/17.
//  Copyright © 2017 Ingresse. All rights reserved.
//

public class JSONConvertible: NSObject {
    
    public func applyJSON(_ json: [String:Any]) {
        for (key,value) in json {
            applyKey(key, value: value)
        }
    }
    
    public func applyKey(_ key: String, value: Any) {
        guard
            self.responds(to: NSSelectorFromString(key)),
            !(value is NSNull)
            else { return }
        
        var val = value
        if let str = value as? String { val = str.trim() }
        
        self.setValue(val, forKey: key)
    }
}
