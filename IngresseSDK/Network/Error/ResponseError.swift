//
//  Copyright © 2020 Ingresse. All rights reserved.
//

public struct ResponseError: Error {
    public enum ErrorType {
        case noData
    }
    
    public let type: ErrorType?
    public let code: Int?
    public let message: String?
    public let error: Error?
    
    public init(type: ErrorType?,
                code: Int?,
                message: String?,
                error: Error?) {
        
        self.type = type
        self.code = code
        self.message = message
        self.error = error
    }
    
    public init(code: Int?,
                message: String?,
                error: Error?) {
        
        self.type = nil
        self.code = code
        self.message = message
        self.error = error
    }
    
    public init(code: Int?,
                message: String?) {
        
        self.type = nil
        self.code = code
        self.message = message
        self.error = nil
    }
    
    public init(type: ErrorType) {
        self.type = type
        self.code = nil
        self.message = nil
        self.error = nil
    }
    
    public init(error: Error) {
        self.type = nil
        self.code = nil
        self.message = nil
        self.error = error
    }
}
