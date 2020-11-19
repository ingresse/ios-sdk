//
//  Copyright © 2020 Ingresse. All rights reserved.
//

import Alamofire

struct UserWalletTicketURLRequest {

    struct GetTickets: NetworkURLRequest {

        private let userId: Int
        private let apiKey: String
        private let request: TicketsRequest
        private let environment: Environment
        private let userAgent: String
        private let authToken: String

        init(userId: Int,
             apiKey: String,
             request: TicketsRequest,
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

        var baseURL: URL? { environment.ticketBaseURL }
        var path: String { "user/\(userId)/tickets" }
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
    var ticketBaseURL: URL? {
        URL(string: "https://\(self.rawValue)\(Host.api.rawValue)")
    }
}
