//
//  Copyright © 2020 Ingresse. All rights reserved.
//

public struct TransfersRequest: Encodable {

    public let usertoken: String
    public let status: String?
    public let page: Int?
    public let pageSize: Int?

    public init(usertoken: String,
                page: Int? = nil,
                pageSize: Int? = nil) {

        self.usertoken = usertoken
        self.status = TransferStatus.pending.rawValue
        self.page = page
        self.pageSize = pageSize
    }

    public init(usertoken: String,
                status: TransferStatus? = nil,
                page: Int? = nil,
                pageSize: Int? = nil) {

        self.usertoken = usertoken
        self.status = status?.rawValue
        self.page = page
        self.pageSize = pageSize
    }

    public init(usertoken: String,
                status: String? = nil,
                page: Int? = nil,
                pageSize: Int? = nil) {

        self.usertoken = usertoken
        self.status = status
        self.page = page
        self.pageSize = pageSize
    }

    public enum TransferStatus: String {

        case pending
        case accepted
    }
}
