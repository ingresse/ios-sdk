//
//  BackstageReportsUrlRequest.swift
//  IngresseSDK
//
//  Created by Phillipi Unger Lino on 16/05/23.
//  Copyright © 2023 Ingresse. All rights reserved.
//

import Alamofire

struct BackstageReportsURLRequest {

    struct GetEntranceReport: NetworkURLRequest {

        private let eventId: String
        private let sessionId: String
        private let apiKey: String
        private let request: EntranceReportRequest
        private let environment: Environment
        private let userAgent: String
        private let authToken: String

        init(eventId: String,
             sessionId: String,
             apiKey: String,
             request: EntranceReportRequest,
             environment: Environment,
             userAgent: String,
             authToken: String) {

            self.eventId = eventId
            self.sessionId = sessionId
            self.apiKey = apiKey
            self.request = request
            self.environment = environment
            self.userAgent = userAgent
            self.authToken = authToken
        }

        var body: Encodable? { nil }
        var baseURL: URL? { environment.ticketBaseURL }
        var path: String { "/api/event/\(eventId)/session/\(sessionId)/report/entrance" }
        var method: HTTPMethod { .get }
        var authenticationType: AuthenticationType? {
            .bearer(token: UserAgent.authorization)
        }
        var headers: [HeaderType]? {
            [.userAgent(header: "User-Agent", authorization: userAgent)]
        }
        var parameters: Encodable? {
            KeyedRequest(request: request, apikey: apiKey)
        }
    }
}

private extension Environment {
    var ticketBaseURL: URL? {
        URL(string: "https://\(self.rawValue)\(Host.backstageReports.rawValue)")
    }
}

