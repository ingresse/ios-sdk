//
//  TransactionSession.swift
//  IngresseSDK
//
//  Created by Rubens Gondek on 6/29/17.
//  Copyright © 2017 Ingresse. All rights reserved.
//

public class TransactionSession: Codable {
    public var id: String = ""
    public var dateTime: DateTime?

    public class DateTime: Codable {
        public var date: String = ""
        public var time: String = ""
        public var timestamp: String = ""
    }
}
