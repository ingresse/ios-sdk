//
//  Copyright © 2017 Ingresse. All rights reserved.
//

public class Refund: NSObject, Codable {
    public var operatorId: String = ""
    public var reason: String = ""
    public var date: String = ""

    enum CodingKeys: String, CodingKey {
        case operatorId = "operator"
        case reason
        case date
    }

    public required init(from decoder: Decoder) throws {
        guard let container = try? decoder.container(keyedBy: CodingKeys.self) else { return }
        date = container.decodeKey(.date, ofType: String.self)
        reason = container.decodeKey(.reason, ofType: String.self)
        operatorId = container.decodeKey(.operatorId, ofType: String.self)
    }
}
