//
//  Copyright © 2018 Ingresse. All rights reserved.
//

public class CompanyLogo: NSObject, Decodable {
    public var small: String = ""
    public var medium: String = ""
    public var large: String = ""
    
    enum CodingKeys: String, CodingKey {
        case small
        case medium
        case large
    }
    
    public required init(from decoder: Decoder)  throws {
        guard let container = try? decoder.container(keyedBy: CodingKeys.self) else { return }
        small = container.decodeKey(.small, ofType: String.self)
        medium = container.decodeKey(.medium, ofType: String.self)
        large = container.decodeKey(.large, ofType: String.self)
    }
}
