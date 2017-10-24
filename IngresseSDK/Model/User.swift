//
//  User.swift
//  IngresseSDK
//
//  Created by Rubens Gondek on 9/20/17.
//  Copyright © 2017 Ingresse. All rights reserved.
//

public class User: JSONConvertible {
    public var id: Int = 0
    public var name: String = ""
    public var email: String = ""
    public var username: String = ""
    public var phone: String = ""
    public var cellphone: String = ""
    public var picture: String = ""

    public override func applyJSON(_ json: [String : Any]) {
        for (key,value) in json {
            if key == "userId" {
                self.applyKey("id", value: value)
                continue
            }

            self.applyKey(key, value: value)
        }
    }
}
