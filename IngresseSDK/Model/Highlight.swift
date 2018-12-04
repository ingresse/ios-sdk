//
//  Copyright © 2017 Ingresse. All rights reserved.
//

public struct Highlight: Decodable {
    public var banner: String = ""
    public var target: String = ""
}

extension Highlight: Equatable {
    public static func == (lhs: Highlight, rhs: Highlight) -> Bool {
        return lhs.banner == rhs.banner && lhs.target == rhs.target
    }
}
