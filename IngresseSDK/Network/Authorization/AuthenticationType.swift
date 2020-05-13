//
//  Copyright © 2020 ingresse. All rights reserved.
//

import Foundation

enum AuthenticationType {

    case bearer(token: String)

    var header: [String: String] {
        switch self {
        case let .bearer(token):
            return ["Authorization": "Bearer \(token)"]
        }
    }
}
