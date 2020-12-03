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
        private let userAgent: String
        private let authToken: String
        
        init(userId: Int,
             apiKey: String,
             request: WalletRequest,
             environment: Environment,
             userAgent: String,
             authToken: String) {

            self.userId = userId
            self.apiKey = apiKey
            self.request = request
            self.environment = environment
            self.userAgent = userAgent
            self.authToken = authToken
        }

        var body: Encodable? { nil }
        var baseURL: URL? { environment.walletBaseURL }
        var path: String { "user/\(userId)/wallet" }
        var method: HTTPMethod { .get }
        var authenticationType: AuthenticationType? { nil}
        var headers: [HeaderType]? {
            [.userAgent(header: userAgent, authorization: authToken)]
        }
        var parameters: Encodable? {
            KeyedRequest(request: request, apikey: apiKey)
        }
    }
}

private extension Environment {
    var walletBaseURL: URL? {
        URL(string: "https://\(self.rawValue)\(Host.api.rawValue)")
    }
}
