//
//  Copyright © 2022 Ingresse. All rights reserved.
//

import Alamofire

public struct RefundTransactionRequest: Encodable {

    public let transactionId: String

    internal let body: Body
    internal let userToken: QueryParam

    public init(userToken: String,
                transactionId: String,
                reason: String) {

        self.transactionId = transactionId
        self.body = Body(reason: reason)
        self.userToken = QueryParam(userToken: userToken)
    }

    internal struct QueryParam: Encodable {
        let usertoken: String

        init(userToken: String) {
            self.usertoken = userToken
        }
    }

    internal struct Body: Encodable {
        let reason: String

        init(reason: String) {
            self.reason = reason
        }
    }
}
