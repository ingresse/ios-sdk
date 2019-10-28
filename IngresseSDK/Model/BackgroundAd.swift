//
//  Copyright © 2018 Ingresse. All rights reserved.
//

import Foundation

public class BackgroundAd: NSObject, Codable {
    public var image: String = ""

    enum CodingKeys: String, CodingKey {
        case image
    }

    public required init(from decoder: Decoder) throws {
        guard let container = try? decoder.container(keyedBy: CodingKeys.self) else { return }
        image = container.decodeKey(.image, ofType: String.self)
    }
}
