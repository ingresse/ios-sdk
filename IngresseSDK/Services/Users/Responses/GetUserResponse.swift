//
//  Copyright © 2022 Ingresse. All rights reserved.
//

public struct GetUserResponse: Decodable {

    public let id: Int?
    public let fbUserId: String?
    public let name: String?
    public let email: String?
    public let verified: Bool?
    public let companyId: Int?
    public let birthdate: String?
    public let gender: String?
    public let additionalFields: String?
    public let createdAt: String?
    public let modifiedAt: String?
    public let deletedAt: String??
    public let identity: Self.Identity?
    public let type: Int?
    public let phone: Self.Phone?
    public let address: Self.Address?
    public let nationality: String?
    public let pictures: [Self.Picture]?

    public struct Identity: Decodable {

        public let type: Self.TypeClass?
        public let id: String?

        public struct TypeClass: Decodable {

            public let id: Int?
            public let name: String?
            public let mask: String?
            public let regex: String?
        }
    }

    public struct Phone: Decodable {

        public let ddi: Int?
        public let number: String?
    }

    public struct Address: Decodable {

        public let street: String?
        public let number: String?
        public let complement: String?
        public let district: String?
        public let city: String?
        public let state: String?
        public let zipcode: String?
    }

    public struct Picture: Decodable {

        public let type: String?
        public let link: String?
    }
}
