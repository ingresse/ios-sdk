//
//  Copyright © 2020 Ingresse. All rights reserved.
//

import Foundation

public class TicketTransferService: BaseService {

    public typealias CustomApiResult<U: Decodable> = ApiResult<U, ResponseError, ResponseError>

    public typealias TransfersResponse = PagedResponse<TicketTransfer>

    public func getTransfers(userId: Int,
                             request: TransfersRequest,
                             queue: DispatchQueue,
                             completion: @escaping (CustomApiResult<TransfersResponse>) -> Void) {

        let urlRequest = TicketTransferURLRequest.GetTransfers(userId: userId,
                                                               apiKey: client.apiKey,
                                                               request: request,
                                                               environment: client.environment,
                                                               userAgent: client.userAgent,
                                                               authToken: client.authToken)

        Network.apiRequest(queue: queue,
                           networkURLRequest: urlRequest,
                           completion: completion)
    }

    public func updateTransfer(transferId: Int,
                               ticketId: Int,
                               request: UpdateTransferRequest,
                               queue: DispatchQueue,
                               completion: @escaping (CustomApiResult<UpdatedTransfer>) -> Void) {

        let urlRequest = TicketTransferURLRequest.UpdateTransfer(apiKey: client.apiKey,
                                                                 transferId: transferId,
                                                                 ticketId: ticketId,
                                                                 request: request,
                                                                 environment: client.environment,
                                                                 userAgent: client.userAgent,
                                                                 authToken: client.authToken)

        Network.apiRequest(queue: queue,
                           networkURLRequest: urlRequest,
                           completion: completion)
    }
}
