//
//  Copyright © 2019 Ingresse. All rights reserved.
//

extension Response {
    public struct Auth {
        public struct TwoFactor: Decodable {
            public var status: Bool? = false
            public var data: TwoFactorData?

            public struct TwoFactorData: Decodable {
                public var token: String? = ""
                public var userId: Int? = -1
                public var authToken: String? = ""
                public var device: TwoFactorDevice?
            }

            public struct TwoFactorDevice: Decodable {
                public var id: String? = ""
                public var name: String? = ""
                public var creationdate: String? = ""
            }
        }
    }
}
