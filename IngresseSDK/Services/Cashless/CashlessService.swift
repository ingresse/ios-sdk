//
//  CashlessService.swift
//  IngresseSDK
//
//  Created by Fernando Ferreira on 23/04/20.
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
