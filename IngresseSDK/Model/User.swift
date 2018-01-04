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
    public var lastname: String = ""
    public var email: String = ""
    public var username: String = ""
    public var phone: String = ""
    public var cellphone: String = ""
    public var picture = [
        "small" : "https://dpz4c7q921os3.cloudfront.net/images/friends-list/user_no_picture.png",
        "medium" : "https://dpz4c7q921os3.cloudfront.net/images/friends-list/user_no_picture.png",
        "large" : "https://dpz4c7q921os3.cloudfront.net/images/friends-list/user_no_picture.png"
    ]

    public override func applyJSON(_ json: [String : Any]) {
        for (key,value) in json {
            if key == "userId" {
                self.applyKey("id", value: value)
                continue
            }
            
            if key == "pictures" {
                guard let pictures = value as? [String:String] else {
                    continue
                }
                
                self.picture["small"] = pictures["small"]
                self.picture["medium"] = pictures["medium"]
                self.picture["large"] = pictures["large"]
                continue
            }

            self.applyKey(key, value: value)
        }
    }
}
