//
//  Copyright © 2020 Ingresse. All rights reserved.
//

public class Disclaimer: NSObject, Codable {
    public var title: String = ""
    public var desc: String = ""

    enum CodingKeys: String, CodingKey {
        case title
        case desc = "description"
    }

    public required init(frim decoder: Decoder) throws {
        let container = try decoder.container(keyedBy: CodingKeys.self)
        title = container.decodeKey(.title, ofType: String.self)
        desc = container.decodeKey(.desc, ofType: String.self)
    }
}
