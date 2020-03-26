//
//  Copyright © 2020 Ingresse. All rights reserved.
//

public class Coupon: NSObject, Decodable {
    public var oldAmount: Double = 0.0
    public var discountAmount: Double = 0.0
    public var newAmount: Double = 0.0

    enum CodingKeys: String, CodingKey {
        case oldAmount
        case discountAmount
        case newAmount
    }

    public required init(from decoder: Decoder) throws {
        let container = try decoder.container(keyedBy: CodingKeys.self)

        oldAmount = container.decodeKey(.oldAmount, ofType: Double.self)
        discountAmount = container.decodeKey(.discountAmount, ofType: Double.self)
        newAmount = container.decodeKey(.newAmount, ofType: Double.self)
    }
}
