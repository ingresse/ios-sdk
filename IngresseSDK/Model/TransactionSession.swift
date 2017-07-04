//
//  TransactionSession.swift
//  IngresseSDK
//
//  Created by Rubens Gondek on 6/29/17.
//  Copyright © 2017 Ingresse. All rights reserved.
//

public class TransactionSession: JSONConvertible {

    public var id: String = ""
    public var date: String = ""
    public var time: String = ""
    public var timestamp: String = ""

    override public func applyJSON(_ json: [String : Any]) {
        for key:String in json.keys {

            if key == "dateTime" {
                guard let datetime = json[key] as? [String:Any] else {
                    continue
                }

                self.date = datetime["date"] as? String ?? ""
                self.time = datetime["time"] as? String ?? ""
                self.timestamp = datetime["timestamp"] as? String ?? ""
                continue
            }

            if !self.responds(to: NSSelectorFromString(key)) {
                continue
            }

            let value = (json[key] is String ? (json[key] as? String)?.trim() : json[key])

            if (value is NSNull || value == nil) {
                continue
            }

            self.setValue(value, forKey: key)
        }
    }
}
