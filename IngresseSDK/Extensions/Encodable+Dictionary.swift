//
//  Copyright © 2020 ingresse. All rights reserved.
//

import Foundation

extension Encodable {

    var encoded: [String: Any]? {
        do {
            let data = try JSONEncoder().encode(self)
            let dictionaryAny = try JSONSerialization.jsonObject(with: data,
                                                                 options: .allowFragments)
            return dictionaryAny as? [String: Any]
        } catch { return nil }
    }
}
