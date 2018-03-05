//
//  User.swift
//  IngresseSDK
//
//  Created by Rubens Gondek on 9/20/17.
//  Copyright © 2017 Ingresse. All rights reserved.
//

public class User: NSObject, Codable {
    public var id: Int = 0
    public var name: String = ""
    public var email: String = ""
    public var username: String = ""
    public var phone: String = ""
    public var cellphone: String = ""
    public var picture: String = ""

    enum CodingKeys: String, CodingKey {
        case id = "userId"
        case name
        case email
        case username
        case phone
        case cellphone
        case picture
    }
}
