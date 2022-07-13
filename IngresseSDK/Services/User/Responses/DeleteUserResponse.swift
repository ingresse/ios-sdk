//
//  DeleteUserResponse.swift
//  IngresseSDK
//
//  Created by Phillipi Unger Lino on 12/07/22.
//  Copyright © 2022 Ingresse. All rights reserved.
//

import Foundation

public struct DeleteUserResponse: Decodable {
    public let status: Bool?

    public enum CodingKeys: String, CodingKey {
        case status
    }
}

