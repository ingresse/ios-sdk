//
//  Copyright © 2020 Ingresse. All rights reserved.
//

public class EventImageDetails: NSObject, Decodable {
    public var imageSizes: EventImageSizes?
    public var imageDescription: EventImageDescription?

    enum CodingKeys: String, CodingKey {
        case imageSizes = "start_image"
        case imageDescription = "start_image_description"
    }

    public required init(from decoder: Decoder) throws {
           guard let container = try? decoder.container(keyedBy: CodingKeys.self) else { return }
         imageSizes = container.safeDecodeKey(.imageSizes, to: EventImageSizes.self)
         imageDescription = container.safeDecodeKey(.imageDescription, to: EventImageDescription.self)
    }
}
