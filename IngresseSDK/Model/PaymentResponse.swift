//
//  Copyright © 2018 Ingresse. All rights reserved.
//

public class PaymentResponse: NSObject, Decodable {
    public var boleto: String = ""
    public var message: String = ""
    public var status: String = ""
    public var tax: Double = 0
    public var total: Double = 0
    public var transactionId: String = ""

    enum CodingKeys: String, CodingKey {
        case boleto
        case message
        case status
        case tax
        case total
        case transactionId
    }

    public override init() {}

    public required init(from decoder: Decoder) throws {
        guard let container = try? decoder.container(keyedBy: CodingKeys.self) else { return }
        boleto = container.decodeKey(.boleto, ofType: String.self)
        message = container.decodeKey(.message, ofType: String.self)
        status = container.decodeKey(.status, ofType: String.self)
        tax = container.decodeKey(.tax, ofType: Double.self)
        total = container.decodeKey(.total, ofType: Double.self)
        transactionId = container.decodeKey(.transactionId, ofType: String.self)
    }

    public static func fromJSON(_ json: [String: Any]) -> PaymentResponse? {
        return JSONDecoder().decodeDict(of: PaymentResponse.self, from: json)
    }
}
