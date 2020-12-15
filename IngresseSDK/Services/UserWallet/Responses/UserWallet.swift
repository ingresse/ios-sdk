//
//  Copyright © 2020 Ingresse. All rights reserved.
//

public struct UserWallet: Decodable {
    public let id: Int
    public let ownerId: Int?
    public let title: String?
    public let desc: String?
    public let type: String?
    public let link: String?
    public let poster: String?
    public let tickets: Int?
    public let transferred: Int?
    public let customTickets: [Self.CustomSessions]?
    public let advertisement: Self.Advertisement?
    public let live: Self.Live?
    public let cashless: Self.Cashless?
    public let sessions: Self.Sessions?
    public let venue: Self.Venue?
    
    enum CodingKeys: String, CodingKey {
        case id
        case ownerId
        case title
        case desc = "description"
        case type
        case link
        case poster
        case tickets
        case transferred = "transfered"
        case customTickets
        case advertisement
        case live
        case cashless
        case sessions
        case venue
    }
}
