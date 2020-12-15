//
//  Copyright © 2020 ingresse. All rights reserved.
//

import Alamofire

protocol NetworkURLRequest {

    var baseURL: URL? { get }
    var path: String { get }
    var method: HTTPMethod { get }
    var parameters: Encodable? { get }
    var body: Encodable? { get }
    var authenticationType: AuthenticationType? { get }
    var headers: [HeaderType]? { get }
}

extension NetworkURLRequest {

    private var encoding: ParameterEncoding {

        switch method {
        case .get, .delete:
            return URLEncoding.default
        case .customPost:
            return URLEncoding.queryString
        default:
            return JSONEncoding.default
        }
    }

    private var headers: HTTPHeaders? {
        var headerList = headers?.compactMap({ $0.content })

        if let authType = authenticationType?.header {
            headerList?.append(authType)
        }

        guard let tupleHeader: [(String, String)] = headerList?.flatMap({ $0 }) else {
            return nil
        }

        let mergedDicts = Dictionary(tupleHeader, uniquingKeysWith: +)

        return HTTPHeaders(mergedDicts)
    }

    func asURLRequest() throws -> URLRequestConvertible {

        guard let url = baseURL?.appendingPathComponent(path) else {
            throw NetworkRequestError.invalidURL
        }

        var urlRequest = try URLRequest(url: url, method: method, headers: headers)

        if method == .customPost {
            let data = try serialize(body)
            urlRequest.httpBody = data
        }

        return try encoding.encode(urlRequest, with: parameters?.encoded)
    }

    private func serialize(_ value: Encodable?) throws -> Data {
        guard let encodedBody: [String: Any] = value?.encoded else {
            throw NetworkRequestError.bodyEncodingFailed
        }
        return try JSONSerialization.data(withJSONObject: encodedBody, options: [])
    }
}

enum NetworkRequestError: Error {

    case invalidURL
    case bodyEncodingFailed
}
