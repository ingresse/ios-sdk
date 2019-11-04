//
//  Copyright © 2017 Ingresse. All rights reserved.
//

public class Advertisement: NSObject, Codable {
    public var eventId: Int = -1
    public var cover: CoverAd?
    public var background: BackgroundAd?

    enum CodingKeys: String, CodingKey {
        case cover
        case background
    }

    public required init(from decoder: Decoder) throws {
        guard let container = try? decoder.container(keyedBy: CodingKeys.self) else { return }
        cover = try container.decodeIfPresent(CoverAd.self, forKey: .cover)
        background = try container.decodeIfPresent(BackgroundAd.self, forKey: .background)
    }
}
