//
//  Copyright © 2017 Ingresse. All rights reserved.
//

public class WalletItem: NSObject, Codable {
    public var id: Int = -1
    public var ownerId: Int = -1
    public var title: String = ""
    public var link: String = ""
    public var type: String = ""
    public var poster: String = ""
    public var eventDescription: String = ""
    public var tickets: Int = 0
    public var transfered: Int = 0
    public var sessions: [Session] = []
    public var customTickets: [CustomTicket] = []
    public var venue: Venue?

    enum CodingKeys: String, CodingKey {
        case id
        case ownerId
        case title
        case link
        case type
        case poster
        case eventDescription = "description"
        case tickets
        case transfered
        case sessions
        case customTickets
        case venue
    }

    enum SessionCodingKeys: String, CodingKey {
        case data
    }

    public required init(from decoder: Decoder) throws {
        guard let container = try? decoder.container(keyedBy: CodingKeys.self) else { return }

        id = container.decodeKey(.id, ofType: Int.self)
        type = container.decodeKey(.type, ofType: String.self)
        link = container.decodeKey(.link, ofType: String.self)
        title = container.decodeKey(.title, ofType: String.self)
        ownerId = container.decodeKey(.ownerId, ofType: Int.self)
        tickets = container.decodeKey(.tickets, ofType: Int.self)
        poster = container.decodeKey(.poster, ofType: String.self)
        transfered = container.decodeKey(.transfered, ofType: Int.self)
        eventDescription = container.decodeKey(.eventDescription, ofType: String.self)
        customTickets = container.decodeKey(.customTickets, ofType: [CustomTicket].self)
        venue = try container.decodeIfPresent(Venue.self, forKey: .venue)

        guard
            let sessionData = try? container.nestedContainer(keyedBy: SessionCodingKeys.self, forKey: .sessions)
            else { return }

        sessions = sessionData.decodeKey(.data, ofType: [Session].self)
    }
}
