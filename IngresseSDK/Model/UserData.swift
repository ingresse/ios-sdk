//
//  UserData.swift
//  IngresseSDK
//
//  Created by Rubens Gondek on 7/20/17.
//  Copyright © 2017 Ingresse. All rights reserved.
//

public class UserData: JSONConvertible {
    public var name: String = ""
    public var lastname: String = ""
    public var email: String = ""
    public var state: String = ""
    public var city: String = ""
    public var district: String = ""
    public var street: String = ""
    public var zip: String = ""
    public var complement: String = ""
    public var phone: String = ""
    public var number: String = ""
    public var fbUserId: String = ""
    public var verified: Bool = false
}
