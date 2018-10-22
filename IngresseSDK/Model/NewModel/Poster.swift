//
//  Copyright © 2018 Ingresse. All rights reserved.
//

public struct Poster: Codable, Equatable {
    public var large: String = ""
    public var medium: String = ""
    public var small: String = ""
    public var xLarge: String = ""

    public init(from decoder: Decoder) throws {
        guard let container = try? decoder.container(keyedBy: CodingKeys.self) else { return }

        large = container.decodeKey(.large, ofType: String.self)
        medium = container.decodeKey(.medium, ofType: String.self)
        small = container.decodeKey(.small, ofType: String.self)
        xLarge = container.decodeKey(.xLarge, ofType: String.self)
    }
}
