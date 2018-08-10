//
//  NewEvent.swift
//  IngresseSDK
//
//  Created by Rubens Gondek on 3/12/18.
//


public struct NewEvent: Decodable, Equatable {

//    public var attributes: Attributes?
    public var categories: [Category] = []
    public var companyId: Int = -1
    public var createdAt: String = ""
    public var desc: String = ""
    public var id: Int = -1
    public var place: Place?
    public var poster: Poster?
    public var producerId: Int = -1
    public var sessions: [Session] = []
    public var slug: String = ""
    public var status: Status?
    public var title: String = ""
    public var updatedAt: String = ""

    enum CodingKeys: String, CodingKey {
        case _source
    }

    enum EventCodingKeys: String, CodingKey {
        case attributes
        case categories
        case companyId
        case createdAt
        case desc = "description"
        case id
        case place
        case poster
        case producerId
        case sessions
        case slug
        case status
        case title
        case updatedAt
    }

    public struct Attributes: Codable {
        public var acceptedApps: [String] = []
        public var accountMode: Bool = false
        public var saleEnabled: Bool = true
    }

    public struct Category: Codable, Equatable {
        public var id: Int = -1
        public var name: String = ""
        public var isPublic: Bool = true
        public var slug: String = ""

        enum CodingKeys: String, CodingKey {
            case id
            case name
            case isPublic = "public"
            case slug
        }
    }

    public struct Place: Codable, Equatable {
        public var city: String = ""
        public var country: String = ""
        public var externalId: String = ""
        public var id: Int = -1
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
                let container = try decoder.container(keyedBy: CodingKeys.self)

                lat = try container.decodeIfPresent(Double.self, forKey: .lat) ?? 0.0
                long = try container.decodeIfPresent(Double.self, forKey: .long) ?? 0.0
            }
        }

        public init(from decoder: Decoder) throws {
            let container = try decoder.container(keyedBy: CodingKeys.self)

            city = try container.decodeIfPresent(String.self, forKey: .city) ?? ""
            country = try container.decodeIfPresent(String.self, forKey: .country) ?? ""
            externalId = try container.decodeIfPresent(String.self, forKey: .externalId) ?? ""
            id = try container.decodeIfPresent(Int.self, forKey: .id) ?? 0
            location = try container.decodeIfPresent(Location.self, forKey: .location)
            name = try container.decodeIfPresent(String.self, forKey: .name) ?? ""
            origin = try container.decodeIfPresent(String.self, forKey: .origin) ?? ""
            state = try container.decodeIfPresent(String.self, forKey: .state) ?? ""
            street = try container.decodeIfPresent(String.self, forKey: .street) ?? ""
            zip = try container.decodeIfPresent(String.self, forKey: .zip) ?? ""
        }
    }

    public struct Poster: Codable, Equatable {
        public var large: String = ""
        public var medium: String = ""
        public var small: String = ""
        public var xLarge: String = ""

        public init(from decoder: Decoder) throws {
            let container = try decoder.container(keyedBy: CodingKeys.self)

            large = try container.decodeIfPresent(String.self, forKey: .large) ?? ""
            medium = try container.decodeIfPresent(String.self, forKey: .medium) ?? ""
            small = try container.decodeIfPresent(String.self, forKey: .small) ?? ""
            xLarge = try container.decodeIfPresent(String.self, forKey: .xLarge) ?? ""
        }
    }

    public struct Session: Codable, Equatable {
        public var dateTime: String = ""
        public var id: Int = -1
        public var status: String = ""
    }

    public struct Status: Codable, Equatable {
        public var id: Int = -1
        public var name: String = ""
    }

    public init(from decoder: Decoder) throws {
        let source = try decoder.container(keyedBy: CodingKeys.self)
        let container = try source.nestedContainer(keyedBy: EventCodingKeys.self, forKey: ._source)

//        attributes = try container.decodeIfPresent(Attributes.self, forKey: .attributes)
        categories = try container.decodeIfPresent([Category].self, forKey: .categories) ?? []
        companyId = try container.decodeIfPresent(Int.self, forKey: .companyId) ?? -1
        createdAt = try container.decodeIfPresent(String.self, forKey: .createdAt) ?? ""
        desc = try container.decodeIfPresent(String.self, forKey: .desc) ?? ""
        id = try container.decodeIfPresent(Int.self, forKey: .id) ?? -1
        place = try container.decodeIfPresent(Place.self, forKey: .place)
        poster = try container.decodeIfPresent(Poster.self, forKey: .poster)
        producerId = try container.decodeIfPresent(Int.self, forKey: .producerId) ?? -1
        sessions = try container.decodeIfPresent([Session].self, forKey: .sessions) ?? []
        slug = try container.decodeIfPresent(String.self, forKey: .slug) ?? ""
        status = try container.decodeIfPresent(Status.self, forKey: .status)
        title = try container.decodeIfPresent(String.self, forKey: .title) ?? ""
        updatedAt = try container.decodeIfPresent(String.self, forKey: .updatedAt) ?? ""
    }
}

