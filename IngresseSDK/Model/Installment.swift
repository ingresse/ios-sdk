//
//  Copyright © 2018 Ingresse. All rights reserved.
//

public class Installment: NSObject, Decodable {
    public var quantity: Int = 0
    public var value: Double = 0
    public var total: Double = 0
    public var taxValue: Double = 0
    public var shippingCost: Double = 0

    enum CodingKeys: String, CodingKey {
        case quantity
        case value
        case total
        case taxValue
        case shippingCost
    }

    public required init(from decoder: Decoder) throws {
        guard let container = try? decoder.container(keyedBy: CodingKeys.self) else { return }
        quantity = container.decodeKey(.quantity, ofType: Int.self)
        value = container.decodeKey(.value, ofType: Double.self)
        total = container.decodeKey(.total, ofType: Double.self)
        taxValue = container.decodeKey(.taxValue, ofType: Double.self)
        shippingCost = container.decodeKey(.shippingCost, ofType: Double.self)
    }
}
