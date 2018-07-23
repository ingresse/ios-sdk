//
//  Copyright © 2017 Ingresse. All rights reserved.
//

public class Venue: NSObject, Codable {
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
    public var location: [Double] = [0.0, 0.0]
    public var lat: Double?
    public var long: Double?

    public var latitude: Double {
        return lat ?? location[1]
    }
    public var longitude: Double {
        return long ?? location[0]
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

    public required init(from decoder: Decoder) throws {
        let container = try decoder.container(keyedBy: CodingKeys.self)
        id = container.decodeKey(.id, ofType: Int.self)
        city = container.decodeKey(.city, ofType: String.self)
        complement = container.decodeKey(.complement, ofType: String.self)
        country = container.decodeKey(.country, ofType: String.self)
        crossStreet = container.decodeKey(.crossStreet, ofType: String.self)
        name = container.decodeKey(.name, ofType: String.self)
        state = container.decodeKey(.state, ofType: String.self)
        street = container.decodeKey(.street, ofType: String.self)
        zipCode = container.decodeKey(.zipCode, ofType: String.self)
        hidden = container.decodeKey(.hidden, ofType: Bool.self)
        location = try container.decodeIfPresent([Double].self, forKey: .location) ?? [0.0 , 0.0]
        lat = try container.decodeIfPresent(Double.self, forKey: .lat)
        long = try container.decodeIfPresent(Double.self, forKey: .long)
    }
}
