//
//  Copyright © 2019 Ingresse. All rights reserved.
//

public class PhoneDDI: NSObject, Decodable {
    public var id: String = ""
    public var name: String = ""
    public var alpha2Code: String = ""
    public var alpha3Code: String = ""
    public var callingCode: String = ""
    public var priority: Int?

    enum CodingKeys: String, CodingKey {
        case id
        case name
        case alpha2Code
        case alpha3Code
        case callingCode
        case priority
    }

    public required init(from decoder: Decoder) throws {
        guard let container = try? decoder.container(keyedBy: CodingKeys.self) else { return }

        id = container.decodeKey(.id, ofType: String.self)
        name = container.decodeKey(.name, ofType: String.self)
        alpha2Code = container.decodeKey(.alpha2Code, ofType: String.self)
        alpha3Code = container.decodeKey(.alpha3Code, ofType: String.self)
        callingCode = container.decodeKey(.callingCode, ofType: String.self)
        priority = container.decodeKey(.priority, ofType: Int.self)
    }
}
