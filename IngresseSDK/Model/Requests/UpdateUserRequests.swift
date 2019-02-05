//
//  Copyright © 2019 Ingresse. All rights reserved.
//

extension Request {
    public struct UpdateUser: Encodable {
        public struct BasicInfos: Encodable {
            public var userId: String = ""
            public var userToken: String = ""
            public var name: String?
            public var lastname: String?
            public var email: String?
            public var phone: String?
            public var cpf: String?
            
            public init() {}
        }
        
        public struct BillingInfos: Encodable {
            public var userId: String = ""
            public var userToken: String = ""
            public var zip: String = ""
            public var street: String = ""
            public var number: String = ""
            public var complement: String = ""
            public var district: String = ""
            public var city: String = ""
            public var state: String = ""
            
            public init() {}
        }
    }
}
