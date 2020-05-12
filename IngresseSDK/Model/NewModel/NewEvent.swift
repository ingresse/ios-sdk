//
//  Copyright © 2018 Ingresse. All rights reserved.
//

public struct NewEvent: Decodable, Equatable {

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
    public var attributes: SearchEventAttributes?
    public var updatedAt: String = ""

    enum CodingKeys: String, CodingKey {
        case source = "_source"
    }

    enum EventCodingKeys: String, CodingKey {
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
        case attributes
        case updatedAt
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
        guard
            let source = try? decoder.container(keyedBy: CodingKeys.self),
            let container = try? source.nestedContainer(keyedBy: EventCodingKeys.self, forKey: .source)
        else { return }

        companyId = container.decodeKey(.companyId, ofType: Int.self)
        createdAt = container.decodeKey(.createdAt, ofType: String.self)
        desc = container.decodeKey(.desc, ofType: String.self)
        id = container.decodeKey(.id, ofType: Int.self)
        producerId = container.decodeKey(.producerId, ofType: Int.self)
        slug = container.decodeKey(.slug, ofType: String.self)
        title = container.decodeKey(.title, ofType: String.self)
        updatedAt = container.decodeKey(.updatedAt, ofType: String.self)

        categories = container.decodeKey(.categories, ofType: [Category].self)
        sessions = container.decodeKey(.sessions, ofType: [Session].self)

        place = container.safeDecodeKey(.place, to: Place.self)
        poster = container.safeDecodeKey(.poster, to: Poster.self)
        status = container.safeDecodeKey(.status, to: Status.self)
        attributes = container.safeDecodeKey(.attributes, to: SearchEventAttributes.self)
    }
}
