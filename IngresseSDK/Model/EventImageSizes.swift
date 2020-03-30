//
//  Copyright © 2020 Ingresse. All rights reserved.
//
public class EventImageSizes: NSObject, Codable {
    public var small: String = ""
    public var medium: String = ""
    public var large: String = ""
    public var xLarge: String = ""

    enum CodingKeys: String, CodingKey {
        case small
        case medium
        case large
        case xLarge
    }

    public required init(from decoder: Decoder) throws {
        guard let container = try? decoder.container(keyedBy: CodingKeys.self) else { return }
        small = container.decodeKey(.small, ofType: String.self)
        medium = container.decodeKey(.medium, ofType: String.self)
        large = container.decodeKey(.large, ofType: String.self)
        xLarge = container.decodeKey(.xLarge, ofType: String.self)
    }
}
