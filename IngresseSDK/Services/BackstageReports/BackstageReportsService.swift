//
//  BackstageReportsService.swift
//  IngresseSDK
//
//  Created by Phillipi Unger Lino on 16/05/23.
//  Copyright © 2023 Ingresse. All rights reserved.
//

public class BackstageReportsService: BaseService {
    public typealias CustomApiResult<U: Decodable> = ApiResult<U, ResponseError, ResponseError>
    
    public func getEntranceReport(eventId: String,
                                  sessionId: String,
                                  request: EntranceReportRequest,
                                  queue: DispatchQueue,
                                  completion: @escaping (CustomApiResult<EntranceReportResponse>) -> Void) {
        
        let urlRequest = BackstageReportsURLRequest.GetEntranceReport(eventId: eventId,
                                                                      sessionId: sessionId,
                                                                      apiKey: client.apiKey,
                                                                      request: request,
                                                                      environment: client.environment,
                                                                      userAgent: client.userAgent,
                                                                      authToken: client.authToken)
        
        Network.apiRequest(queue: queue, networkURLRequest: urlRequest, completion: completion)
    }
}
