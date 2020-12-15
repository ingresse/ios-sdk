//
//  Copyright © 2020 Ingresse. All rights reserved.
//

extension TicketTransfer {

    public struct Event: Decodable {
        public let id: Int?
        public let title: String?
        public let type: String?
        public let status: String?
        public let saleEnabled: Bool?
        public let link: String?
        public let poster: String?
    }

    public struct Session: Decodable {
        public let id: Int?
        public let datetime: String?
    }

    public struct Venue: Decodable {
        public let id: Int?
        public let name: String?
        public let street: String?
        public let crossStreet: String?
        public let zipCode: String?
        public let city: String?
        public let state: String?
        public let country: String?
        public let latitude: Double?
        public let longitude: Double?
        public let hidden: Bool?
        public let complement: String?
    }

    public struct Ticket: Decodable {
        public let id: Int?
        public let guestTypeId: Int?
        public let ticketTypeId: Int?
        public let name: String?
        public let type: String?
        public let desc: String?

        enum CodingKeys: String, CodingKey {
            case id
            case guestTypeId
            case ticketTypeId
            case name
            case type
            case desc = "description"
        }
    }

    public struct ReceivedFrom: Decodable {
        public let transferId: Int?
        public let userId: Int?
        public let email: String?
        public let name: String?
        public let type: String?
        public let status: String?
        public let history: [Self.History]?
        public let socialId: [Self.SocialAccount]?
        public let picture: String?

        public struct History: Decodable {
            public let status: String?
            public let creationDate: String?
        }

        public class SocialAccount: Decodable {
            public let id: String?
            public let network: String?
        }
    }

    public struct Sessions: Decodable {
        public let data: [TicketTransfer.Session]?
    }
}
