//
//  Created by macbook ingresse on 20/11/2018.
//

public class Transaction: NSObject, Decodable {
    public var transactionId: String = ""
    public var gateway: [String: String] = [:]
    public var status: String = ""
    public var availablePaymentMethods: [String: PaymentMethod] = [:]
    public var message: String = ""

    enum CodingKeys: String, CodingKey {
        case transactionId
        case gateway
        case status
        case availablePaymentMethods
        case message
    }

    public required init(from decoder: Decoder) throws {
        guard let container = try? decoder.container(keyedBy: CodingKeys.self) else { return }
        transactionId = container.decodeKey(.transactionId, ofType: String.self)
        gateway = container.decodeKey(.gateway, ofType: [String: String].self)
        status = container.decodeKey(.status, ofType: String.self)
        availablePaymentMethods = container.decodeKey(.availablePaymentMethods, ofType: [String: PaymentMethod].self)
        message = container.decodeKey(.message, ofType: String.self)
    }
}
