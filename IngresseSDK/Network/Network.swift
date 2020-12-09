//
//  Copyright © 2020 ingresse. All rights reserved.
//

import Alamofire

struct Network {
    
    typealias CustomApiResult<U: Decodable> = ApiResult<U, ResponseError, ResponseError>
    
    private static let session = Alamofire.Session.default

    // MARK: - Cancel requests

    static func cancelAllRequests() {
        session.cancelAllRequests()
    }

    // MARK: - Default request

    static func request<U: Decodable>(_ networkURLRequest: NetworkURLRequest,
                                      completion: @escaping (Swift.Result<U, Error>) -> Void) {
        
        let urlRequest: URLRequestConvertible
        do {
            urlRequest = try networkURLRequest.asURLRequest()
        } catch {
            return completion(.failure(error))
        }
        session
            .request(urlRequest)
            .validate()
            .response { response in
                if let error = response.error {
                    return completion(.failure(error))
                }
                
                guard let data = response.data, !data.isEmpty else {
                    let error = ResponseError(type: .noData)
                    return completion(.failure(error))
                }
                
                do {
                    let dataModel = try JSONDecoder().decode(U.self, from: data)
                    return completion(.success(dataModel))
                } catch {
                    return completion(.failure(error))
                }
            }
    }

    // MARK: - Ingresse api request

    static func apiRequest<U: Decodable>(queue: DispatchQueue,
                                         networkURLRequest: NetworkURLRequest,
                                         completion: @escaping (CustomApiResult<U>) -> Void) {

        let urlRequest: URLRequestConvertible
        do {
            urlRequest = try networkURLRequest.asURLRequest()
        } catch {
            let failure = ResponseError(error: error)
            return completion(.failure(failure))
        }

        session
            .request(urlRequest)
            .validate()
            .response(
                queue: queue,
                completionHandler: { response in
                    if let responseError = response.error {
                        let error = ResponseError(error: responseError)
                        return completion(.failure(error))
                    }
                    
                    guard let data = response.data, !data.isEmpty else {
                        let error = ResponseError(type: .noData)
                        return completion(.failure(error))
                    }
                    
                    if let errorData = try? JSONDecoder().decode(IngresseError.self, from: data),
                       errorData.responseError != nil {
                        let error = buildResponseError(errorData)
                        
                        if let code = error.code,
                           Errors.tokenError.contains(code) {
                            return completion(.userTokenError(error))
                        }
                        
                        return completion(.failure(error))
                    }
                    
                    do {
                        let ingresseData = try JSONDecoder().decode(IngresseData<U>.self,
                                                                    from: data)
                        
                        guard let data = ingresseData.responseData else {
                            let error = ResponseError(type: .noData)
                            return completion(.failure(error))
                        }
                        
                        return completion(.success(data))
                    } catch {
                        let failure = ResponseError(error: error)
                        return completion(.failure(failure))
                    }
                })
    }
}

private extension Network {
    static func buildResponseError(_ response: IngresseError) -> ResponseError {
        let errorCode = response.responseError?.code
        let errorCategory = response.responseError?.category ?? ""
        let errorMessage = response.responseError?.message ?? ""
        
        let message = "[\(errorCategory)] \(errorMessage)"
        return ResponseError(code: errorCode, message: message)
    }
}
