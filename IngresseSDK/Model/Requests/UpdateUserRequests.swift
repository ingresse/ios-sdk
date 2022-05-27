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
            public var ddi: String?
            public var phone: String?
            public var cpf: String?
            public var birthdate: String?
            
            public init() {}
            
            private enum CodingKeys: String, CodingKey {
                case name
                case lastname
                case email
                case ddi
                case phone
                case cpf
                case birthdate
            }
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
            
            private enum CodingKeys: String, CodingKey {
                case zip
                case street
                case number
                case complement
                case district
                case city
                case state
            }
        }

        public struct UserCardInsertion: Encodable {
            public var userToken: String = ""
            public var cvv: String = ""
            public var expiration: String = ""
            public var holder: String = ""
            public var number: String = ""

            public init() {}

            private enum CodingKeys: String, CodingKey {
                case cvv
                case expiration
                case holder
                case number
            }
        }
    }
}
