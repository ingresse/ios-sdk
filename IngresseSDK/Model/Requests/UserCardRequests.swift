//
//  Copyright © 2019 Ingresse. All rights reserved.
//

extension Request {
    public struct UserCardWallet: Encodable {
        public struct Insertion: Encodable {
            public var userToken: String = ""
            public var cvv: String = ""
            public var expiration: String = ""
            public var holder: String = ""
            public var number: String = ""
            public var document: String = ""
            
            public init() {}

            private enum CodingKeys: String, CodingKey {
                case cvv
                case expiration
                case holder
                case number
                case document
            }
        }

        public struct Managment: Encodable {
            public var userToken: String = ""
            public var token: String = ""
            public var cardDefault: Bool = true

            public init() {}

            private enum CodingKeys: String, CodingKey {
                case token
                case cardDefault = "default"
            }
        }
    }
}
