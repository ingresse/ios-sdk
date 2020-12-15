//
//  Copyright © 2020 Ingresse. All rights reserved.
//

public extension UserWalletTicket {

    struct Venue: Decodable {
        public let id: Int?
        public let city: String?
        public let complement: String?
        public let country: String?
        public let crossStreet: String?
        public let name: String?
        public let state: String?
        public let street: String?
        public let zipCode: String?
        public let hidden: Bool?
        public let latitude: Double?
        public let longitude: Double?
    }

    struct Live: Decodable {
        public let id: String?
        public let enabled: Bool?
    }

    struct Sessions: Decodable {
        public let data: [Self.SessionData]?

        public struct SessionData: Decodable {
            public let id: Int?
            public let datetime: String?
        }
    }

    struct Transfer: Decodable {
        public let transferId: Int?
        public let userId: Int?
        public let email: String?
        public let name: String?
        public let type: String?
        public let status: String?
        public let history: [Self.History]?
        public let socialId: [Self.SocialId]?
        public let picture: String?

        public struct SocialId: Decodable {
            public let id: String?
            public let network: String?
        }

        public struct History: Decodable {
            public let status: String?
            public let creationDate: String?
        }
    }
}
