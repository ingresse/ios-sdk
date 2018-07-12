//
//  TransactionSessions.swift
//  IngresseSDK
//
//  Created by Mobile Developer on 7/11/18.
//  Copyright © 2018 Ingresse. All rights reserved.
//

public class TransactionSessions: NSObject, Codable {
    public var id: Int = 0
    public var dateTime: DateTimes?
}
public class DateTimes: NSObject, Codable {
    public var date: String = ""
    public var time: String = ""
    public var dateTime: String = ""
}
