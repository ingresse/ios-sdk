//
//  Copyright © 2017 Ingresse. All rights reserved.
//

public class Advertisement: NSObject, Codable {
    public var eventId: Int = -1
    public var cover: CoverAd?
    public var background: BackgroundAd?
    public var imageLink: EventImageSizes?
    public var imageDescription: EventImageDescription?

    enum CodingKeys: String, CodingKey {
        case cover
        case background
        case imageLink = "start_image"
        case imageDescription = "start_image_description"
    }

    public required init(from decoder: Decoder) throws {
        guard let container = try? decoder.container(keyedBy: CodingKeys.self) else { return }
        cover = try container.decodeIfPresent(CoverAd.self, forKey: .cover)
        background = try container.decodeIfPresent(BackgroundAd.self, forKey: .background)
        imageLink = container.safeDecodeKey(.imageLink, to: EventImageSizes.self)
        imageDescription = container.safeDecodeKey(.imageDescription, to: EventImageDescription.self)
    }
}
