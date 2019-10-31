//
//  Copyright © 2018 Ingresse. All rights reserved.
//

extension Request {
    public struct Auth {
        public struct SignUp: Encodable {
            public var name: String = ""
            public var ddi: String = ""
            public var phone: String = ""
            public var email: String = ""
            public var document: String = ""
            public var password: String = ""
            public var token: String?
            public var news: Bool = true

            var emailConfirm: String = ""
            var passCheck: String = ""
            var terms: Bool = true

            private enum CodingKeys: String, CodingKey {
                case name
                case ddi
                case phone
                case email
                case document = "cpf"
                case password
                case token
                case news
                case emailConfirm
                case passCheck
                case terms
            }

            public init() {}
        }
    }
}
