//
//  Copyright © 2018 Ingresse. All rights reserved.
//

public class StartTransaction: Encodable {
    var userId: String = ""
    var eventId: String = ""
    var tickets: [PaymentTicket] = []

    public init(userId: String, eventId: String, tickets: [PaymentTicket]) {
        self.userId = userId
        self.eventId = eventId
        self.tickets = tickets
    }
}
