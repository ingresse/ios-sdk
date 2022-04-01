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
        var baseURL: URL? { environment.baseURL }
        var path: String { "user/transactions" }
        var method: HTTPMethod { .get }
        var authenticationType: AuthenticationType? { nil }
        var headers: [HeaderType]? {
            [.userAgent(header: "User-Agent", authorization: userAgent)]
        }
        var parameters: Encodable? {
            KeyedRequest(request: request, apikey: apiKey)
        }
    }

    struct RefundTransaction: NetworkURLRequest {

        private let request: RefundTransactionRequest
        private let environment: Environment
        private let userAgent: String
        private let apiKey: String
        private let authToken: String

        init(request: RefundTransactionRequest,
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

        var baseURL: URL? { environment.baseURL }
        var path: String { "shop/\(request.transactionId)/refund" }
        var method: HTTPMethod { .customPost }
        var body: Encodable? { request.body }
        var authenticationType: AuthenticationType? { nil }
        var parameters: Encodable? {
            KeyedRequest(request: request.userToken, apikey: apiKey)
        }
        var headers: [HeaderType]? {
            [.applicationJson,
             .userAgent(header: "User-Agent",
                        authorization: userAgent)]
        }
    }
}

private extension Environment {
    var baseURL: URL? {
        URL(string: "https://\(self.rawValue)\(Host.api.rawValue)")
    }
}
