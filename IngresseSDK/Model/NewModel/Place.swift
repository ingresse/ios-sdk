//
//  Copyright © 2018 Ingresse. All rights reserved.
//

public struct Place: Codable, Equatable {
    public var city: String = ""
    public var country: String = ""
    public var externalId: String = ""
    public var location: Location?
    public var name: String = ""
    public var origin: String = ""
    public var state: String = ""
    public var street: String = ""
    public var zip: String = ""

    public struct Location: Codable, Equatable {
        public var lat: Double = 0.0
        public var long: Double = 0.0

        public init(from decoder: Decoder) throws {
            guard let container = try? decoder.container(keyedBy: CodingKeys.self) else { return }

            lat = container.decodeKey(.lat, ofType: Double.self)
            long = container.decodeKey(.long, ofType: Double.self)
        }
    }

    public init(from decoder: Decoder) throws {
        guard let container = try? decoder.container(keyedBy: CodingKeys.self) else { return }

        city = container.decodeKey(.city, ofType: String.self)
        country = container.decodeKey(.country, ofType: String.self)
        externalId = container.decodeKey(.externalId, ofType: String.self)
        name = container.decodeKey(.name, ofType: String.self)
        origin = container.decodeKey(.origin, ofType: String.self)
        state = container.decodeKey(.state, ofType: String.self)
        street = container.decodeKey(.street, ofType: String.self)
        zip = container.decodeKey(.zip, ofType: String.self)

        location = container.safeDecodeKey(.location, to: Location.self)
    }
}
