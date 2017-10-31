//
//  NewTransfer.swift
//  IngresseSDK
//
//  Created by Rubens Gondek on 10/27/17.
//  Copyright © 2017 Ingresse. All rights reserved.
//

public class NewTransfer: JSONConvertible {

    public var id = -1
    public var status = ""
    public var saleTicketId = 0
    public var user = User()

    public override func applyJSON(_ json: [String : Any]) {
        for (key,value) in json {
            if key == "user" {
                guard let userObj = value as? [String:Any] else { continue }

                self.user = User()
                self.user.applyJSON(userObj)
                continue
            }

            self.applyKey(key, value: value)
        }
    }
}
