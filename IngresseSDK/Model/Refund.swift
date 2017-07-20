//
//  Refund.swift
//  IngresseSDK
//
//  Created by Rubens Gondek on 6/29/17.
//  Copyright © 2017 Ingresse. All rights reserved.
//

public class Refund: JSONConvertible {
    public var operatorId: String = ""
    public var reason: String = ""
    public var date: String = ""
    
    public override func applyJSON(_ json: [String : Any]) {
        for key:String in json.keys {
            
            if key == "operator" {
                self.operatorId = json[key] as? String ?? ""
                continue
            }
            
            applyKey(key, json: json)
        }
    }
}
