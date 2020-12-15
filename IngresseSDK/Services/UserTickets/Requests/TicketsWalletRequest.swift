//
//  Copyright © 2020 Ingresse. All rights reserved.
//

public struct TicketsRequest: Encodable {

    public let usertoken: String
    public let eventId: Int?
    public let page: Int?
    public let pageSize: Int?
    public let sessionId: String?
    public let itemType: String?

    public init(usertoken: String,
                eventId: Int?,
                page: Int?,
                pageSize: Int?) {

        self.usertoken = usertoken
        self.eventId = eventId
        self.page = page
        self.pageSize = pageSize
        self.sessionId = nil
        self.itemType = nil
    }

    public init(usertoken: String,
                page: Int?,
                pageSize: Int?) {

        self.usertoken = usertoken
        self.eventId = nil
        self.page = page
        self.pageSize = pageSize
        self.sessionId = nil
        self.itemType = nil
    }

    public init(usertoken: String,
                eventId: Int?,
                page: Int?,
                pageSize: Int?,
                sessionId: String? = nil,
                itemType: TicketType? = nil) {

        self.usertoken = usertoken
        self.eventId = eventId
        self.page = page
        self.pageSize = pageSize
        self.sessionId = sessionId
        self.itemType = itemType?.rawValue
    }

    public enum TicketType: String {
        case ticket
        case passport
    }

    public func getType(_ string: String) -> TicketType {
        if string == TicketType.ticket.rawValue {
            return TicketType.ticket
        }

        return TicketType.passport
    }
}
