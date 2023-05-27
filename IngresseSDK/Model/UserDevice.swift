//
//  UserDevice.swift
//  IngresseSDK
//
//  Created by Phillipi Unger Lino on 27/05/23.
//  Copyright © 2023 Ingresse. All rights reserved.
//

public struct UserDevice: Encodable {
    public let id: String
    public let name: String

    public init(
        id: String,
        name: String
    ) {
        self.id = id
        self.name = name
    }
}
