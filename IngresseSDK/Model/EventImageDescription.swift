//
//  Copyright © 2020 Ingresse. All rights reserved.
//
public class EventImageDescription: NSObject, Codable {
    public var text: String = ""
    public var link: String = ""

    enum CodingKeys: String, CodingKey {
        case text = "image_text"
        case link = "link_text"
    }

    public required init(from decoder: Decoder) throws {
           let container = try decoder.container(keyedBy: CodingKeys.self)
           text = container.decodeKey(.text, ofType: String.self)
           link = container.decodeKey(.link, ofType: String.self)
       }
}
