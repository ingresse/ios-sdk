//
//  CashlessURLRequest.swift
//  IngresseSDK
//
//  Created by Fernando Ferreira on 26/04/20.
//  Copyright © 2020 Ingresse. All rights reserved.
//

import Alamofire

struct CashlessURLRequest {

    struct GetToken: NetworkURLRequest {

        private let eventId: Int
        private let environment: Environment

        init(eventId: Int, environment: Environment) {

            self.eventId = eventId
            self.environment = environment
        }

        var baseURL: URL? { environment.cashlessBaseURL }
        var path: String { "token/\(eventId)" }
        var method: HTTPMethod { .get }
        var parameters: Encodable? { nil }

        var authenticationType: AuthenticationType {

            .bearer(token: UserAgent.authorization)
        }
    }
}

// MARK: - Private extensions
private extension Environment {

    var cashlessBaseURL: URL? {

        URL(string: "https://\(self)-\(Host.cashless.rawValue)")
    }
}
