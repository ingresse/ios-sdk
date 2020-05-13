//
//  Copyright © 2020 ingresse. All rights reserved.
//

import Foundation

public class CashlessService: BaseService {

    public func getToken(eventId: Int,
                         completion: @escaping (Result<CashlessDataTokenResponse, Error>) -> Void) {

        let urlRequest = CashlessURLRequest.GetToken(eventId: eventId,
                                                     environment: client.environment)
        Network.request(urlRequest, completion: completion)
    }
}
