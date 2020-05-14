//
//  Copyright © 2020 ingresse. All rights reserved.
//

import Alamofire

struct Network {

    private static let session = Alamofire.Session.default

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
                    return completion(.failure(ResponseError.noData))
                }
                do {
                    let dataModel = try JSONDecoder().decode(U.self, from: data)
                    return completion(.success(dataModel))
                } catch {
                    return completion(.failure(error))
                }
            }
    }
}

enum ResponseError: Error {

    case noData
}
