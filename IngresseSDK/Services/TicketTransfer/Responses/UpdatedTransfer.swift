//
//  Copyright © 2020 Ingresse. All rights reserved.
//

public struct UpdatedTransfer: Decodable {

    public let saleTicketId: Int?
    public let user: Self.User?
    public let id: Int?
    public let status: String?

    public struct User: Decodable {
        public let id: Int?
        public let email: String?
        public let name: String?
        public let type: String?
        public let social: [Self.SocialAccount]?
        public let picture: String?


        public class SocialAccount: Decodable {
            public let id: String?
            public let network: String?
        }
    }
}
