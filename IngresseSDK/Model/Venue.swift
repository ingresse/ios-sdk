//
//  Venue.swift
//  IngresseSDK
//
//  Created by Rubens Gondek on 7/19/17.
//  Copyright © 2017 Ingresse. All rights reserved.
//

public class Venue: Codable {
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
    public var location: [Double] = [0.0 , 0.0]
    public var lat: Double?
    public var long: Double?

    public var latitude: Double {
        return lat ?? location[0]
    }
    public var longitude: Double {
        return long ?? location[1]
    }

    enum CodingKeys: String, CodingKey {
        case id
        case city
        case complement
        case country
        case crossStreet
        case name
        case state
        case street
        case zipCode
        case hidden
        case location
        case lat = "latitude"
        case long = "longitude"
    }
}
