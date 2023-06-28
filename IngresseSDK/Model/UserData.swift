//
//  Copyright © 2017 Ingresse. All rights reserved.
//

public class UserData: NSObject, Codable {
    public var name: String = ""
    public var lastname: String = ""
    public var email: String = ""
    public var cpf: String = ""
    public var state: String = ""
    public var city: String = ""
    public var district: String = ""
    public var street: String = ""
    public var zip: String = ""
    public var complement: String = ""
    public var ddi: String = ""
    public var phone: String = ""
    public var number: String = ""
    public var document: String = ""
    public var gender: String = ""
    public var nationality: String = ""
    public var birthdate: String = ""
    public var fbUserId: String = ""
    public var verified: Bool = false
    public var type: String = ""
    public var pictures: [String: String] = [:]
    public var picture: String = ""
    public var device: UserDevice? = nil

    enum CodingKeys: String, CodingKey {
        case name
        case lastname
        case email
        case cpf
        case state
        case city
        case district
        case street
        case zip
        case complement
        case ddi
        case phone
        case number
        case document
        case gender
        case nationality
        case birthdate
        case fbUserId
        case verified
        case type
        case pictures
        case picture
        case device
    }

    public required init(from decoder: Decoder) throws {
        guard let container = try? decoder.container(keyedBy: CodingKeys.self) else { return }
        name = container.decodeKey(.name, ofType: String.self)
        lastname = container.decodeKey(.lastname, ofType: String.self)
        email = container.decodeKey(.email, ofType: String.self)
        cpf = container.decodeKey(.cpf, ofType: String.self)
        state = container.decodeKey(.state, ofType: String.self)
        city = container.decodeKey(.city, ofType: String.self)
        district = container.decodeKey(.district, ofType: String.self)
        street = container.decodeKey(.street, ofType: String.self)
        zip = container.decodeKey(.zip, ofType: String.self)
        complement = container.decodeKey(.complement, ofType: String.self)
        ddi = container.decodeKey(.ddi, ofType: String.self)
        phone = container.decodeKey(.phone, ofType: String.self)
        number = container.decodeKey(.number, ofType: String.self)
        birthdate = container.decodeKey(.birthdate, ofType: String.self)
        document = container.decodeKey(.document, ofType: String.self)
        gender = container.decodeKey(.gender, ofType: String.self)
        nationality = container.decodeKey(.nationality, ofType: String.self)
        fbUserId = container.decodeKey(.fbUserId, ofType: String.self)
        verified = container.decodeKey(.verified, ofType: Bool.self)
        type = container.decodeKey(.type, ofType: String.self)
        pictures = container.decodeKey(.pictures, ofType: [String: String].self)
        picture = container.decodeKey(.picture, ofType: String.self)
        device = try? container.decodeIfPresent(UserDevice.self, forKey: .device)
    }
}
