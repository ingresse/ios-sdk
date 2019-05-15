//
//  Copyright © 2017 Ingresse. All rights reserved.
//

public class User: NSObject, Decodable {
    @objc public var id: Int = 0
    @objc public var name: String = ""
    @objc public var email: String = ""
    @objc public var type: String = ""
    @objc public var username: String = ""
    @objc public var phone: String = ""
    @objc public var cellphone: String = ""
    @objc public var pictures: [String: String] = [:]
    @objc public var picture: String = ""
    @objc public var social: [SocialAccount] = []

    enum CodingKeys: String, CodingKey {
        case id
        case name
        case email
        case type
        case username
        case phone
        case cellphone
        case pictures
        case picture
        case social
    }

    public override init() {}

    public required init(from decoder: Decoder) throws {
        guard let container = try? decoder.container(keyedBy: CodingKeys.self) else { return }

        id = container.decodeKey(.id, ofType: Int.self)
        name = container.decodeKey(.name, ofType: String.self)
        email = container.decodeKey(.email, ofType: String.self)
        type = container.decodeKey(.type, ofType: String.self)
        username = container.decodeKey(.username, ofType: String.self)
        phone = container.decodeKey(.phone, ofType: String.self)
        cellphone = container.decodeKey(.cellphone, ofType: String.self)
        pictures = container.decodeKey(.pictures, ofType: [String: String].self)
        picture = container.decodeKey(.picture, ofType: String.self)
        social = container.decodeKey(.social, ofType: [SocialAccount].self)
    }
}
