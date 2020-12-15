//
//  Copyright © 2020 Ingresse. All rights reserved.
//

import Foundation

public class UserWalletTicketService: BaseService {

    public typealias CustomApiResult<U: Decodable> = ApiResult<U, ResponseError, ResponseError>

    public typealias TicketResponse = PagedResponse<UserWalletTicket>

    public func getTickets(userId: Int,
                           request: TicketsRequest,
                           queue: DispatchQueue,
                           completion: @escaping (CustomApiResult<TicketResponse>) -> Void) {

        let urlRequest = UserWalletTicketURLRequest.GetTickets(userId: userId,
                                                               apiKey: client.apiKey,
                                                               request: request,
                                                               environment: client.environment,
                                                               userAgent: client.userAgent,
                                                               authToken: client.authToken)

        Network.apiRequest(queue: queue,
                           networkURLRequest: urlRequest,
                           completion: completion)
    }
}
