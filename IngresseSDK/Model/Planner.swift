//
//  Copyright © 2017 Ingresse. All rights reserved.
//

public class Planner: NSObject, Codable {
    public var id: Int = 0
    public var name: String = ""
    public var username: String = ""
    public var email: String = ""
    public var phone: String = ""
    public var link: String = ""
    public var logo: String = ""

    enum CodingKeys: String, CodingKey {
        case id
        case name
        case username
        case email
        case phone
        case link
        case logo
    }

    public required init(from decoder: Decoder) throws {
        guard let container = try? decoder.container(keyedBy: CodingKeys.self) else { return }
        id = container.decodeKey(.id, ofType: Int.self)
        name = container.decodeKey(.name, ofType: String.self)
        username = container.decodeKey(.username, ofType: String.self)
        email = container.decodeKey(.email, ofType: String.self)
        phone = container.decodeKey(.phone, ofType: String.self)
        link = container.decodeKey(.link, ofType: String.self)
        logo = container.decodeKey(.logo, ofType: String.self)
    }
}
