//
//  Copyright © 2022 Ingresse. All rights reserved.
//

public struct GetUserRequest: Encodable {

    public let queryParam: QueryParam
    public let userId: Int


    public init(userId: Int,
                usertoken: String) {

        self.userId = userId
        self.queryParam = QueryParam(usertoken: usertoken)
    }

    public struct QueryParam: Encodable {

        public let usertoken: String
    }
}
