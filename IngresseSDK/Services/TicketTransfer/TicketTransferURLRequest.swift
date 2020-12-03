//
//  Copyright © 2020 Ingresse. All rights reserved.
//

import Alamofire

struct TicketTransferURLRequest {

    struct GetTransfers: NetworkURLRequest {

        private let userId: Int
        private let apiKey: String
        private let request: TransfersRequest
        private let environment: Environment
        private let userAgent: String
        private let authToken: String

        init(userId: Int,
             apiKey: String,
             request: TransfersRequest,
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
        var baseURL: URL? { environment.transfersBaseURL  }
        var path: String { "user/\(userId)/transfers" }
        var method: HTTPMethod { .get }
        var authenticationType: AuthenticationType? { nil }
        var parameters: Encodable? {
            KeyedRequest(request: request, apikey: apiKey)
        }
        var headers: [HeaderType]? {
            [.userAgent(header: userAgent, authorization: authToken)]
        }
    }

    struct UpdateTransfer: NetworkURLRequest {

        private let apiKey: String
        private let transferId: Int
        private let ticketId: Int
        private let request: UpdateTransferRequest
        private let environment: Environment
        private let userAgent: String
        private let authToken: String

        init(apiKey: String,
             transferId: Int,
             ticketId: Int,
             request: UpdateTransferRequest,
             environment: Environment,
             userAgent: String,
             authToken: String) {

            self.apiKey = apiKey
            self.transferId = transferId
            self.ticketId = ticketId
            self.request = request
            self.environment = environment
            self.userAgent = userAgent
            self.authToken = authToken
        }

        var body: Encodable? { request.body }
        var baseURL: URL? { environment.transfersBaseURL }
        var method: HTTPMethod { .customPost }
        var authenticationType: AuthenticationType? { nil }
        var path: String { "ticket/\(ticketId)/transfer/\(transferId)" }
        var parameters: Encodable? {
            KeyedRequest(request: request.parameters, apikey: apiKey)
        }
        var headers: [HeaderType]? {
            [.userAgent(header: userAgent, authorization: authToken),
             .applicationJson]
        }
    }
}

private extension Environment {
    var transfersBaseURL: URL? {
        URL(string: "https://\(self.rawValue)\(Host.api.rawValue)")
    }
}
