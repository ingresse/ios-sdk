//
//  Copyright © 2018 Ingresse. All rights reserved.
//

public class Address: NSObject, Decodable {
    public var street: String = ""
    public var district: String = ""
    public var state: String = ""
    public var city: String = ""

    enum CodingKeys: String, CodingKey {
        case street
        case district
        case state
        case city
    }

    public required init(from decoder: Decoder) throws {
        guard let container = try? decoder.container(keyedBy: CodingKeys.self) else { return }
        street = container.decodeKey(.street, ofType: String.self)
        district = container.decodeKey(.district, ofType: String.self)
        state = container.decodeKey(.state, ofType: String.self)
        city = container.decodeKey(.city, ofType: String.self)
    }
}
