//
//  Copyright © 2018 Ingresse. All rights reserved.
//

public struct Category: Decodable {
    public var id: Int = -1
    public var name: String = ""
    public var slug: String = ""
    public var isPublic: Bool = false

    enum CodingKeys: String, CodingKey {
        case id
        case name
        case slug
        case isPublic = "public"
    }
}

extension Category: Equatable {
    static public func ==(lhs: Category, rhs: Category) -> Bool {
        return lhs.id == rhs.id
            && lhs.isPublic == rhs.isPublic
            && lhs.name == rhs.name
            && lhs.slug == rhs.slug
    }
}
