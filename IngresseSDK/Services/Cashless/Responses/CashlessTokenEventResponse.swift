//
//  Copyright © 2020 ingresse. All rights reserved.
//

import Foundation

public struct CashlessDataTokenResponse: Decodable {

    public let data: DataToken

    public struct DataToken: Decodable {

        public let baseUrl: String
        public let token: String

        enum CodingKeys: String, CodingKey {

            case baseUrl = "base_url"
            case token
        }
    }
}
