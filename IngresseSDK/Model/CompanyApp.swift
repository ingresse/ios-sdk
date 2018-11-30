//
//  Copyright © 2018 Ingresse. All rights reserved.
//

public class CompanyApp: NSObject, Codable {
    public var id: Int = -1
    public var name: String = ""
    public var publicKey: String = ""
    
    public required init(from decoder: Decoder) throws {
        guard let container = try? decoder.container(keyedBy: CodingKeys.self) else { return }
        id = container.decodeKey(.id, ofType: Int.self)
        name = container.decodeKey(.name, ofType: String.self)
        publicKey = container.decodeKey(.publicKey, ofType: String.self)
    }
}
