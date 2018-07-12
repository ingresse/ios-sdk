//
//  Copyright © 2018 Ingresse. All rights reserved.
//

public class CompanyApp: NSObject, Codable {
    
    public var id: Int = -1
    public var name: String = ""
    public var publicKey: String = ""
    public var privateKey: String = ""
    
    public required init(from decoder: Decoder) throws {
        let container = try decoder.container(keyedBy: CodingKeys.self)
        id = try container.decodeIfPresent(Int.self, forKey: .id) ?? -1
        name = try container.decodeIfPresent(String.self, forKey: .name) ?? ""
        publicKey = try container.decodeIfPresent(String.self, forKey: .publicKey) ?? ""
        privateKey = try container.decodeIfPresent(String.self, forKey: .privateKey) ?? ""
    }
}
