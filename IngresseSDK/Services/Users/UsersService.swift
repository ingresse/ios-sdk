//
//  Copyright © 2022 Ingresse. All rights reserved.
//

import Foundation

public class UsersService: BaseService {

    public typealias CustomApiResult<U: Decodable> = ApiResult<U, ResponseError, ResponseError>

    public func getUser(request: GetUserRequest,
                        queue: DispatchQueue,
                        completion: @escaping (CustomApiResult<GetUserResponse>) -> Void) {

        let urlRequest = UsersURLRequest.GetUser(userId: request.userId,
                                                    apiKey: client.apiKey,
                                                    request: request,
                                                    environment: client.environment,
                                                    userAgent: client.userAgent,
                                                    authToken: client.authToken)

        Network.apiRequest(queue: queue, networkURLRequest: urlRequest, completion: completion)
    }

    public func updateUser(request: UpdateUserRequest,
                           completion: @escaping (Result<Void, ResponseError>) -> Void) {

        let urlRequest = UsersURLRequest.UpdateUser(userId: request.userId,
                                                       apiKey: client.apiKey,
                                                       request: request,
                                                       environment: client.environment,
                                                       userAgent: client.userAgent,
                                                       authToken: client.authToken)

        Network.emptyResponseRequest(urlRequest, completion: completion)
    }
    
    public func createUser(request: CreateUserRequest,
                           queue: DispatchQueue,
                           completion: @escaping (CustomApiResult<CreateUserResponse>) -> Void) {

        let urlRequest = UsersURLRequest.CreateUser(apiKey: client.apiKey,
                                                   request: request,
                                                   environment: client.environment,
                                                   userAgent: client.userAgent,
                                                   authToken: client.authToken)

        Network.apiRequest(queue: queue, networkURLRequest: urlRequest, completion: completion)
    }
}
