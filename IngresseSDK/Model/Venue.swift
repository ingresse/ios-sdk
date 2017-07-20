//
//  Venue.swift
//  IngresseSDK
//
//  Created by Rubens Gondek on 7/19/17.
//  Copyright © 2017 Ingresse. All rights reserved.
//

public class Venue: JSONConvertible {
    public var id: Int = 0
    public var city: String = ""
    public var complement: String = ""
    public var country: String = ""
    public var crossStreet: String = ""
    public var name: String = ""
    public var state: String = ""
    public var street: String = ""
    public var zipCode: String = ""
    public var hidden: Bool = false
    public var latitude: Double = 0.0
    public var longitude: Double = 0.0
}
