//
//  Copyright © 2020 Ingresse. All rights reserved.
//

extension Request {
    public struct Transaction: Encodable {
        public struct UserTransaction: Encodable {
            public var channel: String = ""
            public var status: String = ""
            public var pageSize: Int = 0
            public var page: Int = 0
            
            public init() {}

            private enum CodingKeys: String, CodingKey {
                case channel
                case status
                case pageSize
                case page
            }
        }
    }
}
