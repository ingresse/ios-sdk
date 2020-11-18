//
//  Copyright © 2020 Ingresse. All rights reserved.
//

import Alamofire

struct UserWalletURLRequest {
    
    struct GetWallet: NetworkURLRequest {
        
        private let userId: Int
        private let apiKey: String
        private let request: WalletRequest
        private let environment: Environment
        
        init(userId: Int,
             apiKey: String,
             request: WalletRequest,
             environment: Environment) {
            self.userId = userId
            self.apiKey = apiKey
            self.request = request
            self.environment = environment
        }
        
        var baseURL: URL? { environment.walletBaseURL }
        var path: String { "user/\(userId)/wallet" }
        var method: HTTPMethod { .get }
        var authenticationType: AuthenticationType { .bearer(token: "") }
        var parameters: Encodable? {
            KeyedRequest(request: request,
                         apikey: apiKey)
        }
    }
}

private extension Environment {
    var walletBaseURL: URL? {
        URL(string: "https://\(self.rawValue)\(Host.api.rawValue)")
    }
}
