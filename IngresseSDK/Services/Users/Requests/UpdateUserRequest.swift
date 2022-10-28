//
//  Copyright © 2022 Ingresse. All rights reserved.
//

public struct UpdateUserRequest: Encodable {

    public let parameters: Self.Parameters
    public let body: Self.Body
    public let userId: Int

    public init(userId: Int,
                usertoken: String,
                name: String?,
                email: String?,
                ddi: String?,
                identity: Self.Body.Identity?,
                nationality: Self.Body.UserNationality?,
                birthdate: String?,
                gender: Self.Body.UserGender?,
                aditionalFields: String?,
                password: String?,
                newPassword: String?,
                picture: String?,
                address: Self.Body.Address?) {

        self.userId = userId
        self.parameters = Parameters(usertoken: usertoken)
        self.body = Body(name: name,
                         email: email,
                         ddi: ddi,
                         identity: identity,
                         nationality: nationality?.value,
                         birthdate: birthdate,
                         gender: gender?.value,
                         aditionalFields: aditionalFields,
                         password: password,
                         newPassword: newPassword,
                         picture: picture,
                         address: address)
    }

    public struct Parameters: Encodable {

        public let usertoken: String

        public init(usertoken: String) {

            self.usertoken = usertoken
        }
    }

    public struct Body: Encodable {

        public let name: String?
        public let email: String?
        public let ddi: String?
        public let identity: Self.Identity?
        public let nationality: String?
        public let birthdate: String?
        public let gender: String?
        public let aditionalFields: String?
        public let password: String?
        public let newPassword: String?
        public let picture: String?
        public let address: Self.Address?

        public init(name: String?,
                    email: String?,
                    ddi: String?,
                    identity: Self.Identity?,
                    nationality: Self.UserNationality?,
                    birthdate: String?,
                    gender: Self.UserGender?,
                    aditionalFields: String?,
                    password: String?,
                    newPassword: String?,
                    picture: String?,
                    address: Self.Address?) {


            self.name = name
            self.email = email
            self.ddi = ddi
            self.identity = identity
            self.nationality = nationality?.value
            self.birthdate = birthdate
            self.gender = gender?.value
            self.aditionalFields = aditionalFields
            self.password = password
            self.newPassword = newPassword
            self.picture = picture
            self.address = address
        }

        public init(name: String?,
                    email: String?,
                    ddi: String?,
                    identity: Self.Identity?,
                    nationality: String?,
                    birthdate: String?,
                    gender: String?,
                    aditionalFields: String?,
                    password: String?,
                    newPassword: String?,
                    picture: String?,
                    address: Self.Address?) {

            self.name = name
            self.email = email
            self.ddi = ddi
            self.identity = identity
            self.nationality = nationality
            self.birthdate = birthdate
            self.gender = gender
            self.aditionalFields = aditionalFields
            self.password = password
            self.newPassword = newPassword
            self.picture = picture
            self.address = address
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
