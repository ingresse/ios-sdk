//
//  Copyright © 2020 Ingresse. All rights reserved.
//

public class IdentityType: NSObject, Codable {
    public var id: Int = 0
    public var name: String = ""
    public var mask: String = ""
    public var regex: String = ""
    
    enum CodingKeys: String, CodingKey {
        case id
        case name
        case mask
        case regex
    }
    
    enum SessionCodingKey: String, CodingKey {
        case data
    }
    
    public required init(from decoder: Decoder) throws {
        guard let container = try? decoder.container(keyedBy: CodingKeys.self) else { return }

        id = container.decodeKey(.id, ofType: Int.self)
        name = container.decodeKey(.name, ofType: String.self)
        mask = container.decodeKey(.mask, ofType: String.self)
        regex = container.decodeKey(.regex, ofType: String.self)
    }
}
