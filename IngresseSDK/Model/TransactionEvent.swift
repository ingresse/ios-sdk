//
//  TransactionEvent.swift
//  IngresseSDK
//
//  Created by Rubens Gondek on 6/29/17.
//  Copyright © 2017 Ingresse. All rights reserved.
//

public class TransactionEvent: JSONConvertible {

    public var id: String         = ""

    public var title: String      = ""
    public var type: String       = ""
    public var status: String     = ""
    public var link: String       = ""
    public var poster: String     = ""

    public var venueName: String  = ""

    public var saleEnabled: Bool  = false
    public var taxToCostumer: Int = 0

    override public func applyJSON(_ json: [String : Any]) {
        for key:String in json.keys {

            if key == "venue" {
                guard let venue = json[key] as? [String:Any] else {
                    continue
                }

                self.venueName = venue["name"] as? String ?? ""
                continue
            }

            if key == "saleEnabled" {
                guard let enabled = json[key] as? Int else {
                    continue
                }

                self.saleEnabled = enabled == 1
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
