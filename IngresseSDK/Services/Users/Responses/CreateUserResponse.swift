//
//  CreateUserRequest.swift
//  IngresseSDK
//
//  Created by Phillipi Unger Lino on 30/08/22.
//  Copyright © 2022 Ingresse. All rights reserved.
//

public struct CreateUserResponse: Decodable {
    public let status: Bool?
    public let data: Self.CreateUserResponseData?
    
    public struct CreateUserResponseData: Decodable {
        public let email: String?
        public let document: String?
        public let identity: Self.Identity?
        public let name: String?
        public let lastName: String?
        public let ddi: String?
        public let phone: String?
        public let verified: Bool?
        public let type: String?
        public let birthdate: String?
        public let gender: String?
        public let additionalFields: String?
        public let schemaId: String?
        public let token: String?
        public let userId: Int?
        public let authToken: String?
        public let nationality: String?
        
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
    }
}
