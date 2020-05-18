//
//  Copyright © 2020 Ingresse. All rights reserved.
//

public class WalletEventLive: NSObject, Codable {
    public var id: String = ""
    public var enabled: Bool = false

    enum CodingKeys: String, CodingKey {
        case id
        case enabled
    }

    public required init(from decoder: Decoder) throws {
        let container = try decoder.container(keyedBy: CodingKeys.self)
        id = container.decodeKey(.id, ofType: String.self)
        enabled = container.decodeKey(.enabled, ofType: Bool.self)
    }

    public override init() {
        id = ""
        enabled = false
    }
}
