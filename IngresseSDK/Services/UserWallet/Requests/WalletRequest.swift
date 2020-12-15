//
//  Copyright © 2020 Ingresse. All rights reserved.
//

public struct WalletRequest: Encodable {
    
    public let usertoken: String
    public let from: String?
    public let to: String?
    public let order: String?
    public let page: Int?
    public let pageSize: Int?
    
    public init(usertoken: String,
                page: Int,
                pageSize: Int,
                ordenation: WalletOrdenation) {
        
        self.usertoken = usertoken
        self.from = ordenation.from
        self.to = ordenation.to
        self.order = ordenation.order
        self.page = page
        self.pageSize = pageSize
    }
    
    public init(usertoken: String,
                from: String?,
                to: String?,
                order: String?,
                page: Int?,
                pageSize: Int?) {
        
        self.usertoken = usertoken
        self.from = from
        self.to = to
        self.order = order
        self.page = page
        self.pageSize = pageSize
    }
    
    public func getOrdenation() -> WalletOrdenation {
        if from == .yesterday {
            return WalletOrdenation.future
        }
        
        if to == .yesterday {
            return WalletOrdenation.past
        }
        
        return WalletOrdenation.none
    }
    
    public enum WalletOrdenation {
        case future
        case past
        case none
        
        public var from: String? {
            switch self {
            case .future: return .yesterday
            default: return nil
            }
        }
        
        public var to: String? {
            switch self {
            case .past: return .yesterday
            default: return nil
            }
        }
        
        public var order: String? {
            switch self {
            case .future: return .ascending
            case .past: return .descending
            default: return nil
            }
        }
    }
}

private extension String {
    static let yesterday = "yesterday"
    static let ascending = "ASC"
    static let descending = "DESC"
}
