//
//  Copyright © 2019 Ingresse. All rights reserved.
//

public class WalletInfoPaypal: NSObject, Decodable {
    public var id: String = ""
    public var additional: WalletInfoPaypalAdditional?

    enum CodingKeys: String, CodingKey {
        case id
        case additional
    }

    public required init(from decoder: Decoder) throws {
        guard let container = try? decoder.container(keyedBy: CodingKeys.self) else { return }

        id = container.decodeKey(.id, ofType: String.self)
        additional = container.decodeKey(.additional, ofType: WalletInfoPaypalAdditional.self)
    }
}

public class WalletInfoPaypalAdditional: NSObject, Codable {
    public var email: String = ""

    public required init(from decoder: Decoder) throws {
        guard let container = try? decoder.container(keyedBy: CodingKeys.self) else { return }

        email = container.decodeKey(.email, ofType: String.self)
    }
}
