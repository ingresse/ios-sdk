//
//  Copyright © 2017 Ingresse. All rights reserved.
//

public class GuestTicket: NSObject, Decodable {
    public var id: String = ""
    public var transactionId: String = ""
    public var code: String = ""
    public var userId: String = ""
    public var name: String = ""
    public var email: String = ""
    public var holderUserId: String = ""
    public var holderEmail: String = ""
    public var holderName: String = ""
    public var ticketId: String = ""
    public var ticket: String = ""
    public var type: String = ""
    public var guestTypeId: String = ""
    public var seatLocator: String = ""
    public var checked: Bool = false
    public var lastUpdate: String = ""
    public var soldOnline: String = ""
    public var transferred: Bool = false
    public var external: Bool = false

    enum CodingKeys: String, CodingKey {
        case id
        case transactionId
        case code
        case userId
        case name
        case email
        case holderUserId
        case holderEmail
        case holderName
        case ticketId
        case ticket
        case type
        case guestTypeId
        case seatLocator
        case checked
        case lastUpdate
        case soldOnline
        case transferred
        case external
    }

    public required init(from decoder: Decoder) throws {
        guard let container = try? decoder.container(keyedBy: CodingKeys.self) else { return }

        id = container.decodeKey(.id, ofType: String.self)
        transactionId = container.decodeKey(.transactionId, ofType: String.self)
        code = container.decodeKey(.code, ofType: String.self)
        userId = container.decodeKey(.userId, ofType: String.self)
        name = container.decodeKey(.name, ofType: String.self)
        email = container.decodeKey(.email, ofType: String.self)
        holderUserId = container.decodeKey(.holderUserId, ofType: String.self)
        holderEmail = container.decodeKey(.holderEmail, ofType: String.self)
        holderName = container.decodeKey(.holderName, ofType: String.self)
        ticketId = container.decodeKey(.ticketId, ofType: String.self)
        ticket = container.decodeKey(.ticket, ofType: String.self)
        type = container.decodeKey(.type, ofType: String.self)
        guestTypeId = container.decodeKey(.guestTypeId, ofType: String.self)
        seatLocator = container.decodeKey(.seatLocator, ofType: String.self)
        checked = container.decodeKey(.checked, ofType: Bool.self)
        lastUpdate = container.decodeKey(.lastUpdate, ofType: String.self)
        soldOnline = container.decodeKey(.soldOnline, ofType: String.self)
        transferred = container.decodeKey(.transferred, ofType: Bool.self)
        external = container.decodeKey(.external, ofType: Bool.self)
    }
}
