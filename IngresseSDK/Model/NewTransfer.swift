//
//  NewTransfer.swift
//  IngresseSDK
//
//  Created by Rubens Gondek on 10/27/17.
//  Copyright © 2017 Ingresse. All rights reserved.
//

public class NewTransfer: Codable {

    public var id: Int = -1
    public var status: String = ""
    public var saleTicketId: Int = 0
    public var user: User?
}
