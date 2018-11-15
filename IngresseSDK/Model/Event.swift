//
//  Copyright © 2017 Gondek. All rights reserved.
//

public class Event: NSObject, Decodable {
    public var id: Int = 0
    public var title: String = ""
    public var link: String = ""
    public var type: String = ""
    public var poster: String = ""
    public var status: String = ""
    public var rsvpTotal: Int = 0
    public var saleEnabled: Bool = false
    public var eventDescription: String = ""
    public var rsvp: [User] = []
    public var date: [EventDate] = []
    public var customTickets: [CustomTicket] = []
    public var planner: Planner?
    public var venue: Venue?

    enum CodingKeys: String, CodingKey {
        case eventDescription = "description"
        case id
        case title
        case link
        case type
        case poster
        case status
        case rsvpTotal
        case saleEnabled
        case rsvp
        case date
        case customTickets
        case planner
        case venue
    }

    public required init(from decoder: Decoder) throws {
        let container = try decoder.container(keyedBy: CodingKeys.self)

        id = container.decodeKey(.id, ofType: Int.self)
        saleEnabled = container.decodeKey(.saleEnabled, ofType: Bool.self)
        rsvpTotal = container.decodeKey(.rsvpTotal, ofType: Int.self)
        eventDescription = container.decodeKey(.eventDescription, ofType: String.self)
        title = container.decodeKey(.title, ofType: String.self)
        link = container.decodeKey(.link, ofType: String.self)
        type = container.decodeKey(.type, ofType: String.self)
        poster = container.decodeKey(.poster, ofType: String.self)
        status = container.decodeKey(.status, ofType: String.self)
        customTickets = container.decodeKey(.customTickets, ofType: [CustomTicket].self)
        rsvp = container.decodeKey(.rsvp, ofType: [User].self)
        date = container.decodeKey(.date, ofType: [EventDate].self)
        
        planner = container.safeDecodeKey(.planner, to: Planner.self)
        venue = container.safeDecodeKey(.venue, to: Venue.self)
    }
}
