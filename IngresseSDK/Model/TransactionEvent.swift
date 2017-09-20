//
//  TransactionEvent.swift
//  IngresseSDK
//
//  Created by Rubens Gondek on 6/29/17.
//  Copyright © 2017 Ingresse. All rights reserved.
//

public class TransactionEvent: JSONConvertible {
    public var id: String = ""

    public var title: String = ""
    public var type: String = ""
    public var status: String = ""
    public var link: String = ""
    public var poster: String = ""

    public var venueName: String = ""

    public var saleEnabled: Bool = false
    public var taxToCostumer: Int = 0

    override public func applyJSON(_ json: [String : Any]) {
        for (key,value) in json {
            if key == "venue" {
                guard let venue = value as? [String:Any] else { continue }

                self.venueName = venue["name"] as? String ?? ""
                continue
            }

            if key == "saleEnabled" {
                guard let enabled = value as? Int else { continue }

                self.saleEnabled = enabled == 1
                continue
            }

            applyKey(key, value: value)
        }
    }
}
