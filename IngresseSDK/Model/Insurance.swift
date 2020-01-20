//
//  Copyright © 2020 Ingresse. All rights reserved.
//

public class Insurance: Decodable {
    public var enable: Bool = false
    public var rate: Int = 0
    public var value: Int = 0

    enum CodingKeys: String, CodingKey {
        case enable
        case rate
        case value
    }

    public required init(from decoder: Decoder) throws {
        guard let container = try? decoder.container(keyedBy: CodingKeys.self) else { return }
        enable = container.decodeKey(.enable, ofType: Bool.self)
        rate = container.decodeKey(.rate, ofType: Int.self)
        value = container.decodeKey(.value, ofType: Int.self)
    }
}
