//
//  Copyright © 2019 Ingresse. All rights reserved.
//

public class DeclinedReason: NSObject, Codable {
    @objc public var message: String?
    @objc public var declinedBy: String?
    @objc public var code: String?
    @objc public var createdAt: String?

    enum CodingKeys: String, CodingKey {
        case message
        case declinedBy
        case createdAt
        case code
    }

    public required init(from decoder: Decoder) throws {
        guard let container = try? decoder.container(keyedBy: CodingKeys.self) else { return }
        message = container.decodeKey(.message, ofType: String.self)
        declinedBy = container.decodeKey(.declinedBy, ofType: String.self)
        createdAt = container.decodeKey(.createdAt, ofType: String.self)
        code = container.decodeKey(.code, ofType: String.self)
    }
}
