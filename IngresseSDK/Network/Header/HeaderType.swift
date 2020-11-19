//
//  Copyright © 2020 Ingresse. All rights reserved.
//

enum HeaderType {

    case userAgent(header: String, authorization: String)
    case applicationJson

    public var content: [String: String] {
        switch self {
        case let .userAgent(header, authorization):
            return [header: authorization]
        case .applicationJson:
            return ["content-type": "application/json"]
        }
    }
}
