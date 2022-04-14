//
//  Copyright © 2022 Ingresse. All rights reserved.
//

import Foundation

public class ApiUserService: BaseService {

    public typealias CustomApiResult<U: Decodable> = ApiResult<U, ResponseError, ResponseError>

    public typealias UserTransactionsResponse = PagedResponse<UserTransactionResponse>

    public func getTransactions(request: UserTransactionsRequest,
                                queue: DispatchQueue,
                                completion: @escaping (CustomApiResult<UserTransactionsResponse>) -> Void) {

        let urlRequest = ApiUserURLRequest.GetTransactions(request: request,
                                                           environment: client.environment,
                                                           userAgent: client.userAgent,
                                                           apiKey: client.apiKey,
                                                           authToken: client.authToken)

        Network.apiRequest(queue: queue, networkURLRequest: urlRequest, completion: completion)
    }

    public func refundTransaction(request: RefundTransactionRequest,
                                  queue: DispatchQueue,
                                  completion: @escaping (CustomApiResult<TransactionRefundedResponse>) -> Void) {

        let urlRequest = ApiUserURLRequest.RefundTransaction(request: request,
                                                             environment: client.environment,
                                                             userAgent: client.userAgent,
                                                             apiKey: client.apiKey,
                                                             authToken: client.authToken)

        Network.apiRequest(queue: queue, networkURLRequest: urlRequest, completion: completion)
    }
}
