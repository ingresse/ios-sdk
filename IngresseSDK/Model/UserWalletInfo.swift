//
//  Copyright © 2019 Ingresse. All rights reserved.
//

public class UserWalletInfo: NSObject, Decodable {
    public var paypal: [WalletInfoPaypal] = []
    public var creditCard: [WalletInfoCreditCard] = []

    enum CodingKeys: String, CodingKey {
        case paypal
        case creditCard
    }

    public required init(from decoder: Decoder) throws {
        guard let container = try? decoder.container(keyedBy: CodingKeys.self) else { return }

        paypal = container.decodeKey(.paypal, ofType: [WalletInfoPaypal].self)
        creditCard = container.decodeKey(.creditCard, ofType: [WalletInfoCreditCard].self)
    }
}
