//
//  Copyright © 2020 Ingresse. All rights reserved.
//

@frozen public enum ApiResult<Success, Failure: Error, UserTokenError: Error> {
    
    case success(Success)
    case failure(Failure)
    case userTokenError(UserTokenError)
}
