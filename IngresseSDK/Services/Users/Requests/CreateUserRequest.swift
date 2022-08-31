//
//  CreateUserRequest.swift
//  IngresseSDK
//

public struct CreateUserRequest: Encodable {

    public let body: Self.Body

    public init(name: String,
                email: String,
                password: String,
                ddi: String,
                phone: String,
                identity: Self.Body.Identity,
                nationality: Self.Body.UserNationality,
                birthdate: String,
                gender: Self.Body.UserGender,
                aditionalFields: String?) {
        
        self.body = Body(name: name,
                         email: email,
                         password: password,
                         ddi: ddi,
                         phone: phone,
                         identity: identity,
                         nationality: nationality.value,
                         birthdate: birthdate,
                         gender: gender.value,
                         aditionalFields: aditionalFields)
    }

    public struct Body: Encodable {

        public let name: String
        public let email: String
        public let password: String
        public let ddi: String
        public let phone: String
        public let identity: Self.Identity
        public let nationality: String
        public let birthdate: String
        public let gender: String
        public let aditionalFields: String?

        public init(name: String,
                    email: String,
                    password: String,
                    ddi: String,
                    phone: String,
                    identity: Self.Identity,
                    nationality: Self.UserNationality,
                    birthdate: String,
                    gender: Self.UserGender,
                    aditionalFields: String?) {
            self.name = name
            self.email = email
            self.password = password
            self.ddi = ddi
            self.phone = phone
            self.identity = identity
            self.nationality = nationality.value
            self.birthdate = birthdate
            self.gender = gender.value
            self.aditionalFields = aditionalFields
        }
        
        public init(name: String,
                    email: String,
                    password: String,
                    ddi: String,
                    phone: String,
                    identity: Self.Identity,
                    nationality: String,
                    birthdate: String,
                    gender: String,
                    aditionalFields: String?) {

            self.name = name
            self.email = email
            self.password = password
            self.ddi = ddi
            self.phone = phone
            self.identity = identity
            self.nationality = nationality
            self.birthdate = birthdate
            self.gender = gender
            self.aditionalFields = aditionalFields
        }

        public struct Identity: Encodable {

            public let type: Int
            public let id: String

            public enum IdentityType {
                case cpf
                case internationalId
                case passport

                public var value: Int {
                    switch self {
                    case .cpf: return 1
                    case .internationalId: return 2
                    case .passport: return 3
                    }
                }
            }

            public init(type: IdentityType,
                        id: String) {

                self.type = type.value
                self.id = id
            }

            public init(type: Int,
                        id: String) {

                self.type = type
                self.id = id
            }
        }

        public enum UserNationality {

            case brazilian
            case foreign

            public var value: String {
                switch self {
                case .brazilian: return "BR"
                case .foreign: return "UN"
                }
            }
        }

        public enum UserGender {

            case femaleCisgender
            case femaleTransgender
            case maleCisgender
            case maleTransgender
            case nonBinary
            case other

            public var value: String {
                switch self {
                case .femaleCisgender: return "FC"
                case .femaleTransgender: return "FT"
                case .maleCisgender: return "MC"
                case .maleTransgender: return "MT"
                case .nonBinary: return "NB"
                case .other: return "O"
                }
            }
        }

        public struct Address: Encodable {

            public let street: String?
            public let number: String?
            public let complement: String?
            public let district: String?
            public let city: String?
            public let state: String?
            public let zip: String?
        }
    }
}

