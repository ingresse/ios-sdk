//
//  Copyright © 2017 Ingresse. All rights reserved.
//

public class CustomTicket: NSObject, Codable {
    public var name: String = ""
    public var slug: String = ""
    public var status: String = ""

    public required init(from decoder: Decoder) throws {
        guard let container = try? decoder.container(keyedBy: CodingKeys.self) else { return }
        name = container.decodeKey(.name, ofType: String.self)
        slug = container.decodeKey(.slug, ofType: String.self)
        status = container.decodeKey(.status, ofType: String.self)
    }
}
