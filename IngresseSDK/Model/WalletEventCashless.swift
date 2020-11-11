//
//  Copyright © 2020 ingresse. All rights reserved.
//

import Foundation

public struct WalletEventCashless: NSObject, Codable {

    public let enabled: Bool

    init() {
        enabled = false
    }
}
