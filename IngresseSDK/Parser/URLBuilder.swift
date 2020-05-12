//
//  Copyright © 2017 Gondek. All rights reserved.
//

public enum Environment: String {
    case prod = ""
    case hml = "hml-"
    case hmlA = "hmla-"
    case hmlB = "hmlb-"
    case test = "test-"
    case stg = "stg-"
    case integration = "integration2-"
    case undefined = "undefined-"

    public init(envType: String) {
        switch envType {
        case "prod":
            self = .prod
        case "hml":
            self = .hml
        case "hmla":
            self = .hmlA
        case "hmlb":
            self = .hmlB
        case "test":
            self = .test
        case "stg":
            self = .stg
        case "integration2-":
            self = .integration
        default:
            self = .undefined
        }
    }
}

public enum Host: String {
    case events = "event.ingresse.com/"
    case api = "api.ingresse.com/"
    case cep = "cep.ingresse.com/"
    case search = "event-search.ingresse.com/"
    case searchHml = "event.ingresse.com/search/company/"
    case userTransactions = "my-transactions.ingresse.com/"
}

public class URLBuilder: NSObject {
    private var url: String = ""
    private var host: Host = .api
    private var environment: Environment = .prod
    private var path: String = ""
    private var apiKey: String = ""
    private var parameters: [String: String] = [:]

    public init(client: IngresseClient) {
        self.environment = client.environment
        self.apiKey = client.apiKey
    }
    
    public func setHost(_ endpoint: Host) -> URLBuilder {
        self.host = endpoint

        return self
    }

    public func setEnvironment(_ env: Environment) -> URLBuilder {
        self.environment = env
        
        return self
    }
    
    public func setPath(_ path: String) -> URLBuilder {
        self.path = path
        
        return self
    }
    
    public func setKeys(apiKey: String) -> URLBuilder {
        self.apiKey = apiKey
        
        return self
    }
    
    public func addParameter(key: String, value: Any?) -> URLBuilder {
        guard let value = value else { return self }
        self.parameters[key] = "\(value)"
        
        return self
    }

    func addEncodableParameter( _ param: Encodable) -> URLBuilder {
        var builder = self
        param.encoded?.forEach { builder = builder.addParameter(key: $0, value: $1) }
        return builder
    }
    
    public func build() throws -> URLRequest {
        var urlString = getHostUrl()
        urlString += path

        let params = parameters.merging(authorizationAPIParam()) { _, key in key }
        if !params.isEmpty {

            urlString += "?"
            urlString += params.stringFromHttpParameters()
        }

        guard let url = URL(string: urlString) else {
            throw URLRequestError.requestInvalid
        }
        let request = URLRequest(url: url,
                                 cachePolicy: .useProtocolCachePolicy,
                                 timeoutInterval: 60)
        return requestWithHeaders(request)
    }

    public func getHostUrl() -> String {
        if [.hml, .hmlA, .hmlB].contains(environment) && host == .search {
            return "https://\(environment.rawValue)\(Host.searchHml.rawValue)"
        }
        return "https://\(environment.rawValue)\(host.rawValue)"
    }
}

// MARK: - Private Methods
extension URLBuilder {

    private func requestWithHeaders(_ request: URLRequest) -> URLRequest {

        var request = request
        if let header = UserAgent.header {

            request.addValue(header, forHTTPHeaderField: "User-Agent")
        }

        if let auth = UserAgent.authorization {

            request.addValue("Bearer \(auth)", forHTTPHeaderField: "Authorization")
        }
        authorizationAPIParam().forEach {

            request.addValue($0.value,
                             forHTTPHeaderField: $0.key)
        }
        return request
    }

    private func authorizationAPIParam() -> [String: String] {

        switch host {
        case .api:

            return ["apikey": apiKey]
        case .userTransactions:

            return ["X-Api-Key": "fcEpWMJGBp4oXfA1qEQ6maSepdyrZd2v4yk7q4xv"]
        default:

            return [:]
        }
    }
}

// MARK: - URLRequestError
enum URLRequestError: Error {

    case requestInvalid
}
