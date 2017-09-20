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
    public var user: User?
    
    public override func applyJSON(_ json: [String : Any]) {
        for (key,value) in json {
            if key == "user" {
                guard let userObj = value as? [String:Any] else { continue }
                
                self.user = User()
                self.user?.applyJSON(userObj)
                continue
            }
            
            applyKey(key, value: value)
        }
    }
}
