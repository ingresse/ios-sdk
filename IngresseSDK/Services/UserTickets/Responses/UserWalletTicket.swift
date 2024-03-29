//
//  Copyright © 2020 Ingresse. All rights reserved.
//

public struct UserWalletTicket: Decodable {
    public let id: Int
    public let guestTypeId: Int?
    public let ticketTypeId: Int?
    public let itemType: String?
    public let price: Double?
    public let tax: Double?
    public let sessions: Self.Sessions?
    public let title: String?
    public let type: String?
    public let eventId: Int?
    public let eventTitle: String?
    public let eventVenue: Self.Venue?
    public let transactionId: String?
    public let desc: String?
    public let sequence: String?
    public let code: String?
    public let checked: Bool?
    public let receivedFrom: Self.Transfer?
    public let transferredTo: Self.Transfer?
    public let currentHolder: Self.Transfer?
    public let live: Self.Live?
    public let transferable: Bool?
    public let isResalable: Bool?
    public let resalableUrl: String?
    public let isTransferable: Bool?
    public let isTransferCancelable: Bool?
    public let isReturnable: Bool?
    public let secret: String?

    enum CodingKeys: String, CodingKey {
        case id
        case guestTypeId
        case ticketTypeId
        case itemType
        case price
        case tax
        case sessions
        case title
        case type
        case eventId
        case eventTitle
        case eventVenue
        case transactionId
        case desc = "description"
        case sequence
        case code
        case checked
        case receivedFrom
        case transferredTo = "transferedTo"
        case currentHolder
        case live
        case transferable
        case isResalable
        case resalableUrl
        case isTransferable
        case isTransferCancelable
        case isReturnable
        case secret
    }
}
