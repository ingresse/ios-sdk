//
//  Copyright © 2022 Ingresse. All rights reserved.
//

import Alamofire

struct UsersURLRequest {

    struct UpdateUser: NetworkURLRequest {

        private let userId: Int
        private let apiKey: String
        private let request: UpdateUserRequest
        private let environment: Environment
        private let userAgent: String
        private let authToken: String

        init(userId: Int,
             apiKey: String,
             request: UpdateUserRequest,
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

        var baseURL: URL? { environment.usersBaseURL }
        var path: String { "users/\(userId)" }
        var method: HTTPMethod { .put }
        var body: Encodable? { request.body }
        var authenticationType: AuthenticationType? { nil }
        var parameters: Encodable? {
            KeyedRequest(request: request.parameters, apikey: apiKey)
        }
        var headers: [HeaderType]? {
            [.userAgent(header: userAgent, authorization: authToken),
             .applicationJson]
        }
    }

    struct GetUser: NetworkURLRequest {

        private let userId: Int
        private let apiKey: String
        private let request: GetUserRequest
        private let environment: Environment
        private let userAgent: String
        private let authToken: String

        init(userId: Int,
             apiKey: String,
             request: GetUserRequest,
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

        var baseURL: URL? { environment.usersBaseURL }
        var path: String { "users/\(userId)" }
        var method: HTTPMethod { .get }
        var body: Encodable? { "" }
        var authenticationType: AuthenticationType? { nil }
        var parameters: Encodable? {
            KeyedRequest(request: request.queryParam, apikey: apiKey)
        }
        var headers: [HeaderType]? {
            [.userAgent(header: "User-Agent", authorization: userAgent)]
        }
    }
}

private extension Environment {
    var usersBaseURL: URL? {
        URL(string: "https://\(self.rawValue)\(Host.api.rawValue)")
    }
}
