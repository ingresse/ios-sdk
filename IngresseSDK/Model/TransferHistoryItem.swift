//
//  TransferHistoryItem.swift
//  IngresseSDK
//
//  Created by Rubens Gondek on 7/12/17.
//  Copyright © 2017 Ingresse. All rights reserved.
//

public class TransferHistoryItem: JSONConvertible {
    public var id: Int = 0
    public var status: String = ""
    public var datetime: String = ""
    public var user: SimpleUser?
    
    public override func applyJSON(_ json: [String : Any]) {
        for key:String in json.keys {
            
            if key == "user" {
                guard let userObj = json[key] as? [String:Any] else {
                    continue
                }
                
                self.user = SimpleUser()
                self.user?.applyJSON(userObj)
                continue
            }
            
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
