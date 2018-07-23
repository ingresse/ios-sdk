//
//  Copyright © 2018 Ingresse. All rights reserved.
//

public class CoverAd: NSObject, Decodable {
    public var image: String = ""
    public var url: String = ""

    enum CodingKeys: String, CodingKey {
        case image
        case url
    }

    public required init(from decoder: Decoder) throws {
        guard let container = try? decoder.container(keyedBy: CodingKeys.self) else { return }
        image = container.decodeKey(.image, ofType: String.self)
        url = container.decodeKey(.url, ofType: String.self)
    }
}
