//
//  LoginUserDevice.swift
//  IngresseSDK
//
//  Created by Phillipi Unger Lino on 27/05/23.
//  Copyright © 2023 Ingresse. All rights reserved.
//

public struct LoginUserDevice: Encodable {
    public let id: String
    public let name: String
    public let type: String

    public init(
        id: String,
        name: String,
        type: String
    ) {
        self.id = id
        self.name = name
        self.type = type
    }
    
    func toJsonString() -> String? {
        guard let data = try? JSONEncoder().encode(self) else { return nil }
        let jsonString = String(decoding: data, as: UTF8.self)
        return jsonString
    }
}
