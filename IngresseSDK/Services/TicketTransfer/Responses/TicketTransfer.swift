//
//  Copyright © 2020 Ingresse. All rights reserved.
//

public struct TicketTransfer: Decodable {
    public let id: Int
    public let event: Self.Event?
    public let session: Self.Session?
    public let venue: Self.Venue?
    public let ticket: Self.Ticket?
    public let receivedFrom: Self.ReceivedFrom?
    public let sessions: Self.Sessions?
}
