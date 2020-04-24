//
//  NetworkURLRequest.swift
//  Alamofire
//
//  Created by Fernando Ferreira on 23/04/20.
//

import Alamofire

protocol NetworkURLRequest {

    var baseURL: URL? { get }
    var path: String { get }
    var method: HTTPMethod { get }
    var parameters: Encodable? { get }
    var authenticationType: AuthenticationType { get }
}

extension NetworkURLRequest {

    private var encoding: ParameterEncoding {

        switch method {
        case .get, .delete:

            return URLEncoding.default
        default:

            return JSONEncoding.default
        }
    }

    private var headers: HTTPHeaders {

        return HTTPHeaders(authenticationType.header)
    }

    func asURLRequest() throws -> URLRequestConvertible {

        guard let url = baseURL?.appendingPathComponent(path) else {

            throw NetworkRequestError.invalidURL
        }

        let urlRequest = try URLRequest(url: url, method: method, headers: headers)
        return try encoding.encode(urlRequest, with: parameters?.encoded)
    }
}

enum NetworkRequestError: Error {

    case invalidURL
}
