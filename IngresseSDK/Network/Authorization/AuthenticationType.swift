//
//  AuthenticationType.swift
//  IngresseSDK
//
//  Created by Fernando Ferreira on 23/04/20.
//

import Foundation

enum AuthenticationType {

    case bearer(token: String)

    var header: [String: String] {

        switch self {
        case let .bearer(token):

            return ["Authorization": "Bearer \(token)"]
        }
    }
}
