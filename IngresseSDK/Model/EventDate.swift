//
//  EventDate.swift
//  IngresseSDK
//
//  Created by Rubens Gondek on 12/5/17.
//  Copyright © 2017 Ingresse. All rights reserved.
//

public class EventDate: JSONConvertible {
    public var id: Int = 0
    public var date: String = ""
    public var time: String = ""
    public var status: String = ""

    public override func applyJSON(_ json: [String : Any]) {
        for (key,value) in json {
            if key == "dateTime" {
                guard let dateTime = value as? [String:Any] else { continue }

                applyKey("date", value: dateTime["date"] ?? "")
                applyKey("time", value: dateTime["time"] ?? "")
                continue
            }

            applyKey(key, value: value)
        }
    }
}
