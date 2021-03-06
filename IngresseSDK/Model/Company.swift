//
//  Copyright © 2018 Ingresse. All rights reserved.
//

public class Company: NSObject, Decodable {
    @objc public var id: Int = -1
    @objc public var name: String = ""
    @objc public var logo: CompanyLogo?

    enum CodingKeys: String, CodingKey {
        case id
        case name
        case logo
    }
    
    public required init(from decoder: Decoder) throws {
        guard let container = try? decoder.container(keyedBy: CodingKeys.self) else { return }
        id = container.decodeKey(.id, ofType: Int.self)
        name = container.decodeKey(.name, ofType: String.self)
        logo = container.safeDecodeKey(.logo, to: CompanyLogo.self)
    }
}
