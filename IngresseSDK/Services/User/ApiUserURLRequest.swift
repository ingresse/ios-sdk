//
//  Copyright © 2022 Ingresse. All rights reserved.
//

import Alamofire

struct ApiUserURLRequest {

    struct GetTransactions: NetworkURLRequest {

        private let request: UserTransactionsRequest
        private let environment: Environment
        private let userAgent: String
        private let apiKey: String
        private let authToken: String

        init(request: UserTransactionsRequest,
             environment: Environment,
             userAgent: String,
             apiKey: String,
             authToken: String) {

            self.request = request
            self.environment = environment
            self.userAgent = userAgent
            self.apiKey = apiKey
            self.authToken = authToken
        }

        var body: Encodable? { "" }
        var baseURL: URL? { environment.userTransactionsBaseURL }
        var path: String { "user/transactions" }
        var method: HTTPMethod { .get }
        var authenticationType: AuthenticationType? { nil }
        var headers: [HeaderType]? {
            [.userAgent(header: userAgent, authorization: authToken)]
        }
        var parameters: Encodable? {
            KeyedRequest(request: request, apikey: apiKey)
        }
    }
}

private extension Environment {
    var userTransactionsBaseURL: URL? {
        URL(string: "https://\(self.rawValue)\(Host.api.rawValue)")
    }
}
