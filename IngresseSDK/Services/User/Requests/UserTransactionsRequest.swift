//
//  Copyright © 2022 Ingresse. All rights reserved.
//

import Alamofire

public struct UserTransactionsRequest: Encodable {
    
    public let userToken: String
    public let status: String?
    public let pageSize: Int?
    public let page: Int?
    
    public init(userToken: String) {
        
        self.userToken = userToken
        self.status = nil
        self.pageSize = nil
        self.page = nil
    }
    
    public init(userToken: String,
                status: Self.Status?,
                pageSize: Int?,
                page: Int?) {
        
        self.userToken = userToken
        self.status = status?.rawValue
        self.pageSize = pageSize
        self.page = page
    }
    
    public init(userToken: String,
                status: [Self.Status]?,
                pageSize: Int?,
                page: Int?) {
        
        self.userToken = userToken
        self.status = status?
            .map {$0.rawValue}
            .joined(separator: ",")
        self.pageSize = pageSize
        self.page = page
    }
    
    public enum Status: String, Encodable {
        case approved = "approved"
        case authorized = "authorized"
        case declined = "declined"
        case error = "error"
        case manualReview = "manual review"
        case pending = "pending"
        case refund = "refund"
    }
}
