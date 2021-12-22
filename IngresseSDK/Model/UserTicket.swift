//
//  Copyright © 2016 Gondek. All rights reserved.
//

public class UserTicket: NSObject, Codable {
    public var id: Int = 0
    public var holderId: Int = 0
    public var guestTypeId: Int = 0
    public var ticketTypeId: Int = 0
    public var transactionId: String = ""
    
    public var code: String = ""
    public var itemType: String = ""
    public var sequence: String = ""
    public var guestName: String?
    public var title: String = ""
    public var type: String = ""
    public var desc: String = ""
    public var checked: Bool = false
    
    public var sessions: [Session] = []
    
    public var eventId: Int = 0
    public var eventTitle: String = ""
    public var eventVenue: Venue?
    public var live: WalletEventLive = WalletEventLive()
    public var transferable: Bool = false
    public var isResalable: Bool = false
    public var resalableUrl: String = ""
    public var isTransferable: Bool = false
    public var isTransferCancelable: Bool = false
    public var isReturnable: Bool = false
    
    public var receivedFrom: Transfer?
    public var transferedTo: Transfer?
    
    public var currentHolder: Transfer?

    enum CodingKeys: String, CodingKey {
        case id
        case holderId
        case guestTypeId
        case ticketTypeId
        case transactionId
        case code
        case itemType
        case sequence
        case guestName
        case title
        case type
        case desc = "description"
        case checked
        case sessions
        case eventId
        case eventTitle
        case eventVenue
        case live
        case transferable
        case isResalable
        case resalableUrl
        case isTransferable
        case isTransferCancelable
        case isReturnable
        case receivedFrom
        case transferedTo
        case currentHolder
    }

    enum SessionCodingKey: String, CodingKey {
        case data
    }

    public required init(from decoder: Decoder) throws {
        guard let container = try? decoder.container(keyedBy: CodingKeys.self) else { return }

        id = container.decodeKey(.id, ofType: Int.self)
        holderId = container.decodeKey(.holderId, ofType: Int.self)
        guestTypeId = container.decodeKey(.guestTypeId, ofType: Int.self)
        ticketTypeId = container.decodeKey(.ticketTypeId, ofType: Int.self)
        transactionId = container.decodeKey(.transactionId, ofType: String.self)
        code = container.decodeKey(.code, ofType: String.self)
        itemType = container.decodeKey(.itemType, ofType: String.self)
        sequence = container.decodeKey(.sequence, ofType: String.self)
        guestName = container.decodeKey(.guestName, ofType: String.self)
        title = container.decodeKey(.title, ofType: String.self)
        type = container.decodeKey(.type, ofType: String.self)
        desc = container.decodeKey(.desc, ofType: String.self)
        checked = container.decodeKey(.checked, ofType: Bool.self)
        eventId = container.decodeKey(.eventId, ofType: Int.self)
        eventTitle = container.decodeKey(.eventTitle, ofType: String.self)
        eventVenue = container.safeDecodeKey(.eventVenue, to: Venue.self)
        live = try container.decodeIfPresent(WalletEventLive.self, forKey: .live) ?? WalletEventLive()
        transferable = container.decodeKey(.transferable, ofType: Bool.self)
        isResalable = container.decodeKey(.transferable, ofType: Bool.self)
        resalableUrl = container.decodeKey(.resalableUrl, ofType: String.self)
        isTransferable = container.decodeKey(.isTransferable, ofType: Bool.self)
        isTransferCancelable = container.decodeKey(.isTransferCancelable, ofType: Bool.self)
        isReturnable = container.decodeKey(.isReturnable, ofType: Bool.self)
        receivedFrom = container.safeDecodeKey(.receivedFrom, to: Transfer.self)
        transferedTo = container.safeDecodeKey(.transferedTo, to: Transfer.self)
        currentHolder = container.safeDecodeKey(.currentHolder, to: Transfer.self)

        guard
            let sessionData = try? container.nestedContainer(keyedBy: SessionCodingKey.self, forKey: .sessions)
            else { return }

        sessions = sessionData.decodeKey(.data, ofType: [Session].self)
    }
}
