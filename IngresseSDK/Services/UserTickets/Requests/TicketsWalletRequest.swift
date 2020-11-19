//
//  Copyright © 2020 Ingresse. All rights reserved.
//

public struct TicketsRequest: Encodable {

    public let usertoken: String
    public let evendId: Int?
    public let page: Int?
    public let pageSize: Int?

    public init(usertoken: String,
                eventId: Int?,
                page: Int?,
                pageSize: Int?) {

        self.usertoken = usertoken
        self.evendId = eventId
        self.page = page
        self.pageSize = pageSize
    }

    public init(usertoken: String,
                page: Int?,
                pageSize: Int?) {

        self.usertoken = usertoken
        self.evendId = nil
        self.page = page
        self.pageSize = pageSize
    }
}
