//
//  Copyright © 2019 Ingresse. All rights reserved.
//

public class WalletInfoCreditCard: NSObject, Decodable {
    public var token: String = ""
    public var holder: String = ""
    public var firstSix: String = ""
    public var lastFour: String = ""
    public var expiration: String = ""
    public var brand: String = ""
    public var defaultCard: Bool = false
    public var createdAt: String = ""

    enum CodingKeys: String, CodingKey {
        case token
        case holder
        case firstSix
        case lastFour
        case expiration
        case brand
        case defaultCard = "default"
        case createdAt
    }

    public required init(from decoder: Decoder) throws {
        guard let container = try? decoder.container(keyedBy: CodingKeys.self) else { return }

        token = container.decodeKey(.token, ofType: String.self)
        holder = container.decodeKey(.holder, ofType: String.self)
        firstSix = container.decodeKey(.firstSix, ofType: String.self)
        lastFour = container.decodeKey(.lastFour, ofType: String.self)
        expiration = container.decodeKey(.expiration, ofType: String.self)
        brand = container.decodeKey(.brand, ofType: String.self)
        defaultCard = container.decodeKey(.defaultCard, ofType: Bool.self)
        createdAt = container.decodeKey(.createdAt, ofType: String.self)
    }
}
