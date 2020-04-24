//
//  Network.swift
//  Alamofire
//
//  Created by Fernando Ferreira on 23/04/20.
//

import Alamofire

struct Network {

    private static let session = Alamofire.Session.default

    static func request<U: Decodable>(_ request: URLRequest,
                                      completion: @escaping (Swift.Result<U, Error>) -> Void) {
        session
            .request(request)
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
