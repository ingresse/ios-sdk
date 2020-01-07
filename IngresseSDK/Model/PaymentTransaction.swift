//
//  Copyright © 2019 Ingresse. All rights reserved.
//

public class PaymentTransaction: NSObject, Decodable {
    @objc public var declinedReason: DeclinedReason?
    
    enum CodingKeys: String, CodingKey {
        case declinedReason
    }
    
    public required init(from decoder: Decoder) throws {
        guard let container = try? decoder.container(keyedBy: CodingKeys.self) else { return }
        declinedReason = container.safeDecodeKey(.declinedReason, to: DeclinedReason.self)
    }
}
