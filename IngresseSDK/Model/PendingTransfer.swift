//
//  Copyright © 2017 Ingresse. All rights reserved.
//

public class PendingTransfer: NSObject, Decodable {
    public var id: Int = 0
    public var event: Event?
    public var venue: Venue?
    public var session: Session?
    public var ticket: TransferTicket?
    public var receivedFrom: Transfer?
    public var sessions: [Session] = []

    enum CodingKeys: String, CodingKey {
        case id
        case event
        case venue
        case session
        case ticket
        case receivedFrom
        case sessions
    }

    enum SessionCodingKeys: String, CodingKey {
        case data
    }

    public required init(from decoder: Decoder) throws {
        guard let container = try? decoder.container(keyedBy: CodingKeys.self) else { return }

        id = container.decodeKey(.id, ofType: Int.self)
        event = container.safeDecodeKey(.event, to: Event.self)
        venue = container.safeDecodeKey(.venue, to: Venue.self)
        session = container.safeDecodeKey(.session, to: Session.self)
        ticket = container.safeDecodeKey(.ticket, to: TransferTicket.self)
        receivedFrom = container.safeDecodeKey(.receivedFrom, to: Transfer.self)

        guard
            let sessionData = try? container.nestedContainer(keyedBy: SessionCodingKeys.self, forKey: .sessions)
            else { return }

        sessions = sessionData.decodeKey(.data, ofType: [Session].self)
    }
}
