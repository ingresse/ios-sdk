//
//  Copyright © 2020 Ingresse. All rights reserved.
//

import Foundation

public class UserWalletService: BaseService {
    
    public typealias CustomApiResult<U: Decodable> = ApiResult<U, ResponseError, ResponseError>
    
    public typealias WalletResponse = PagedResponse<UserWallet>
    
    public func getWallet(userId: Int,
                          request: WalletRequest,
                          queue: DispatchQueue,
                          completion: @escaping (CustomApiResult<WalletResponse>) -> Void) {
        
        let urlRequest = UserWalletURLRequest.GetWallet(userId: userId,
                                                        apiKey: client.apiKey,
                                                        request: request,
                                                        environment: client.environment)
        
        Network.apiRequest(queue: queue,
                           networkURLRequest: urlRequest,
                           completion: completion)
    }
}
