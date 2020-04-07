//
//  Copyright © 2020 Ingresse. All rights reserved.
//

extension Request {
    public struct Transaction {
        public struct UserTransaction: Encodable {

            public let channel: String
            public let status: String
            public let pageSize: Int
            public let page: Int

            public init(channel: String,
                        status: String,
                        pageSize: Int,
                        page: Int) {

                self.channel = channel
                self.status = status
                self.pageSize = pageSize
                self.page = page
            }
        }
    }
}
