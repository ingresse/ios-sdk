//
//  Copyright © 2020 ingresse. All rights reserved.
//

import Alamofire

protocol NetworkURLRequest {

    var baseURL: URL? { get }
    var path: String { get }
    var method: HTTPMethod { get }
    var parameters: Encodable? { get }
    var authenticationType: AuthenticationType? { get }
    var headers: [HeaderType]? { get }
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

    private var headers: HTTPHeaders? {
        var mergedDicts: [String: String]?

        if let authType = authenticationType?.header {
            mergedDicts?.merge(authType) { current, _ in current }
        }

        headers?
            .compactMap({ $0.content })
            .forEach({ content in
                mergedDicts?.merge(content) { current, _ in current }
            })

        guard let headers = mergedDicts else { return nil }
        return HTTPHeaders(headers)
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
