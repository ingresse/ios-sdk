//
//  TransactionEvent.swift
//  IngresseSDK
//
//  Created by Rubens Gondek on 6/29/17.
//  Copyright © 2017 Ingresse. All rights reserved.
//

public class TransactionEvent: Codable {
    public var id: String = ""

    public var title: String = ""
    public var type: String = ""
    public var status: String = ""
    public var link: String = ""
    public var poster: String = ""

    public var venue: Venue?

    public var saleEnabled: Bool = false
    public var taxToCostumer: Int = 0

    public class Venue: Codable {
        public var name: String = ""
    }
}
