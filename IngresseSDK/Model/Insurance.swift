//
//  Copyright © 2020 Ingresse. All rights reserved.
//

public class Insurance: Decodable {
    public var enabled: Bool = false
    public var rate: Float = 0
    public var value: Float = 0
    public var partner: String = ""
    
    enum CodingKeys: String, CodingKey {
        case enabled
        case rate
        case value
        case partner
    }
    
    public required init(from decoder: Decoder) throws {
        guard let container = try? decoder.container(keyedBy: CodingKeys.self) else { return }
        enabled = container.decodeKey(.enabled, ofType: Bool.self)
        rate = container.decodeKey(.rate, ofType: Float.self)
        value = container.decodeKey(.value, ofType: Float.self)
        partner = container.decodeKey(.partner, ofType: String.self)
    }
}
