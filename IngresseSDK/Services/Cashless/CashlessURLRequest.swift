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

        private let eventId: String
        private let environment: Environment

        init(eventId: String, environment: Environment) {

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


private extension Environment {

    var cashlessBaseURL: URL? {

        URL(string: "https://\(Host.cashless)\(self)")
    }
}
