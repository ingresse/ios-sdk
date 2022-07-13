//
//  DeleteUserRequest.swift
//  IngresseSDK
//
//  Created by Phillipi Unger Lino on 12/07/22.
//  Copyright © 2022 Ingresse. All rights reserved.
//

import Alamofire

public struct DeleteUserRequest: Encodable {

    public let userId: String
    internal let userToken: QueryParam

    public init(userToken: String,
                userId: String) {

        self.userId = userId
        self.userToken = QueryParam(userToken: userToken)
    }

    internal struct QueryParam: Encodable {
        let usertoken: String

        init(userToken: String) {
            self.usertoken = userToken
        }
    }
}
