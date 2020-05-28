//
//  Copyright © 2020 Ingresse. All rights reserved.
//

public class Identity: NSObject, Codable {
    public var type: IdentityType?
    public var id: String = ""
    
    enum CodingKeys: String, CodingKey {
        case type
        case id
    }
    
    public required init(from decoder: Decoder) throws {
         guard let container = try? decoder.container(keyedBy: CodingKeys.self) else { return }

        type = container.decodeKey(.type, ofType: IdentityType.self)
        id = container.decodeKey(.id, ofType: String.self)
     }
}
