//
//  Copyright © 2019 Ingresse. All rights reserved.
//

extension Response {
    public struct Events {
        public struct SpecialEvent: Decodable {
            public var type: String? = ""
            public var btntext: String? = ""
            public var url: String? = ""
        }

        public struct RSVP: Decodable {
            public var data: [RSVPUser]? = []
        }

        public struct RSVPUser: Decodable {
            public var email: String? = ""
            public var id: Int? = -1
            public var name: String? = ""
            public var picture: String? = ""
        }
    }
}

extension Response {
    public struct UserWalletTransactions {
        public struct Transaction: Decodable {
            public var transactionId: String? = ""
        }
    }
}
