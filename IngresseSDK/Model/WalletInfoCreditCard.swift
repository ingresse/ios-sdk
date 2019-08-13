//
//  Copyright © 2019 Ingresse. All rights reserved.
//

public class WalletInfoCreditCard: NSObject, Decodable {
    public var brand: String = ""
    public var defaultCard: Bool = false
    public var createdAt: String = ""

    public var expiration: String = ""
    public var firstSix: String = ""
    public var holder: WalletInfoHolder?
    public var lastFour: String = ""
    public var token: String = ""
    
    enum CodingKeys: String, CodingKey {
        case brand
        case defaultCard = "default"
        case expiration
        case firstSix
        case holder
        case lastFour
        case token
    }

    public required init(from decoder: Decoder) throws {
        guard let container = try? decoder.container(keyedBy: CodingKeys.self) else { return }

        token = container.decodeKey(.token, ofType: String.self)
        holder = container.decodeKey(.holder, ofType: WalletInfoHolder.self)
        firstSix = container.decodeKey(.firstSix, ofType: String.self)
        lastFour = container.decodeKey(.lastFour, ofType: String.self)
        expiration = container.decodeKey(.expiration, ofType: String.self)
        brand = container.decodeKey(.brand, ofType: String.self)
        defaultCard = container.decodeKey(.defaultCard, ofType: Bool.self)
    }
}
