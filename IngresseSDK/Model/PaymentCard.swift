//
//  Copyright © 2017 Ingresse. All rights reserved.
//

public class PaymentCard: NSObject, Codable {
    public var firstDigits: String = ""
    public var lastDigits: String = ""

    public required init(from decoder: Decoder) throws {
        guard let container = try? decoder.container(keyedBy: CodingKeys.self) else { return }
        firstDigits = container.decodeKey(.firstDigits, ofType: String.self)
        lastDigits = container.decodeKey(.lastDigits, ofType: String.self)
    }
}
