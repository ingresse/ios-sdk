//
//  Customer.swift
//  IngresseSDK
//
//  Created by Rubens Gondek on 6/29/17.
//  Copyright © 2017 Ingresse. All rights reserved.
//

public class Customer: JSONConvertible {

    public var id: Int = 0
    public var email: String = ""
    public var name: String = ""
    public var phone: Int = 0
    public var picture: String = ""
    public var username: String = ""
}
