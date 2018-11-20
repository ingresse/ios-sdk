//
//  Copyright © 2018 Ingresse. All rights reserved.
//

public class PaymentMethod: NSObject, Decodable {
    public var paymentType: String = ""
    public var installments: [Installment] = []

    enum CodingKeys: String, CodingKey {
        case paymentType = "type"
        case installments
    }

    public required init(from decoder: Decoder) throws {
        guard let container = try? decoder.container(keyedBy: CodingKeys.self) else { return }
        paymentType = container.decodeKey(.paymentType, ofType: String.self)
        installments = container.decodeKey(.installments, ofType: [Installment].self)
    }
}
