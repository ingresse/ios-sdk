//
//  Copyright © 2019 Ingresse. All rights reserved.
//

public class WalletInfoHolder: NSObject, Decodable {
    public var document: String = ""
    public var name: String = ""

    enum CodingKeys: String, CodingKey {
        case document
        case name
    }

    public required init(from decoder: Decoder) throws {
        guard let container = try? decoder.container(keyedBy: CodingKeys.self) else { return }

        document = container.decodeKey(.document, ofType: String.self)
        name = container.decodeKey(.name, ofType: String.self)
    }
}
