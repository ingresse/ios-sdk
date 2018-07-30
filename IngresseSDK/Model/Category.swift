//
//  Copyright © 2018 Ingresse. All rights reserved.
//

public struct Category: Decodable, Equatable {

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
