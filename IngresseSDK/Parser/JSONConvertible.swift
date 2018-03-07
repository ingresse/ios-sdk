//
//  JSONConvertible.swift
//  IngresseSDK
//
//  Created by Rubens Gondek on 5/12/17.
//  Copyright © 2017 Ingresse. All rights reserved.
//

@objcMembers public class JSONConvertible: NSObject {
    
    required public override init() {

    }

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

    public func applyArray<T:JSONConvertible>(key: String, value: Any, of type: T.Type) {

        guard self.responds(to: NSSelectorFromString(key)) else { return }

        var data: [[String:Any]]?
        if let dictionary = value as? [String:Any] {
            data = dictionary["data"] as? [[String:Any]]
        } else {
            data = value as? [[String:Any]]
        }

        guard let array = data else { return }

        self.setValue([], forKey: key)

        var values = [T]()
        for obj in array {
            let value = T()
            value.applyJSON(obj)

            values.append(value)
        }

        self.setValue(values, forKey: key)
    }
}
