//
//  Copyright © 2017 Ingresse. All rights reserved.
//

public class UpdatedUser: NSObject, Decodable {
    public var ddi: String = ""
    public var phone: String = ""
    public var id: String = ""
    public var lastname: String = ""
    public var verified: Bool = false
    public var email: String = ""
    public var cpf: String = ""
    public var name: String = ""

    enum CodingKeys: String, CodingKey {
        case ddi
        case phone
        case id
        case lastname
        case verified
        case email
        case cpf
        case name
    }

    public override init() {}

    public required init(from decoder: Decoder) throws {
        guard let container = try? decoder.container(keyedBy: CodingKeys.self) else { return }
        ddi = container.decodeKey(.ddi, ofType: String.self)
        phone = container.decodeKey(.phone, ofType: String.self)
        id = container.decodeKey(.id, ofType: String.self)
        lastname = container.decodeKey(.lastname, ofType: String.self)
        verified = container.decodeKey(.verified, ofType: Bool.self)
        email = container.decodeKey(.email, ofType: String.self)
        cpf = container.decodeKey(.cpf, ofType: String.self)
        name = container.decodeKey(.name, ofType: String.self)
    }
}
