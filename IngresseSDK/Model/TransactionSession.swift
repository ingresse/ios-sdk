//
//  TransactionSession.swift
//  IngresseSDK
//
//  Created by Rubens Gondek on 6/29/17.
//  Copyright © 2017 Ingresse. All rights reserved.
//

public class TransactionSession: NSObject, Codable {
    public var id: String = ""
    public var dateTime: DateTime?

}
public class DateTime: NSObject, Codable {
    public var date: String = ""
    public var time: String = ""
    
    var tms: String?
    var dateTime: String?
    
    public var timestamp: String {
        return tms ?? dateTime ?? ""
    }
    
    enum CodingKeys: String, CodingKey {
        case tms = "timestamp"
        case date
        case time
        case dateTime
    }
    
    public required init(from decoder: Decoder) throws {
        let container = try decoder.container(keyedBy: CodingKeys.self)
        tms = try container.decodeIfPresent(String.self, forKey: .tms)
        date = try container.decodeIfPresent(String.self, forKey: .date) ?? ""
        time = try container.decodeIfPresent(String.self, forKey: .time) ?? ""
        dateTime = try container.decodeIfPresent(String.self, forKey: .dateTime)
    }
}
