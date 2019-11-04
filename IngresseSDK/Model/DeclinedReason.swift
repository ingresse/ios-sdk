//
//  Copyright © 2019 Ingresse. All rights reserved.
//

public class DeclinedReason: Codable {
    public var message: String?
    public var code: String?

    enum CodingKeys: String, CodingKey {
        case message
        case code
    }

    public required init(from decoder: Decoder) throws {
        guard let container = try? decoder.container(keyedBy: CodingKeys.self) else { return }
        message = container.decodeKey(.message, ofType: String.self)
        code = container.decodeKey(.code, ofType: String.self)
    }
}
