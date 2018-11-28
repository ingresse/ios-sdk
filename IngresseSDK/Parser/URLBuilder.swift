//
//  URLBuilder.swift
//  IngresseSDK
//
//  Created by Rubens Gondek on 1/10/17.
//  Copyright © 2017 Gondek. All rights reserved.
//

public enum Environment: String {
    case prod = ""
    case hml = "hml-"
    case test = "test-"
    case stg = "stg-"
}

public enum Host: String {
    case events = "event.ingresse.com/"
    case api = "api.ingresse.com/"
    case cep = "cep.ingresse.com/"
    case search = "event-search.ingresse.com/"
    case searchHml = "event.ingresse.com/search/company/"
}

public class URLBuilder: NSObject {
    
    private var url: String = ""
    private var host: Host = .api
    private var environment: Environment = .prod
    private var path: String = ""
    private var apiKey: String = ""
    private var parameters: [String:String] = [:]
    
    public init(client: IngresseClient) {
        self.environment = client.environment
        self.apiKey = client.apiKey
    }
    
    public func setHost(_ endpoint: Host) -> URLBuilder {
        self.host = endpoint

        return self
    }

    public func setEnvironment(_ env: Environment)  -> URLBuilder {
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
    
    public func addParameter(key: String, value: Any) -> URLBuilder {
        self.parameters[key] = "\(value)"
        
        return self
    }
    
    public func build() -> String {
        var url = buildWithoutKeys()

        if !parameters.isEmpty {
            url += "&"
        }

        url += generateAuthString(apiKey: apiKey)

        return url
    }

    public func buildWithoutKeys() -> String {
        var url = getHostUrl()
        url += path
        url += "?"

        if !parameters.isEmpty {
            url += parameters.stringFromHttpParameters()
        }

        return url
    }

    /// Generate stardart ingresse auth string
    ///
    /// - Parameters:
    ///   - apiKey: app's key
    /// - Returns: Auth string with api key
    public func generateAuthString(apiKey: String) -> String {
        return "apikey=\(apiKey)"
    }

    public func getHostUrl() -> String {
        if environment == .hml && host == .search {
            return "https://\(environment.rawValue)\(Host.searchHml.rawValue)"
        }
        return "https://\(environment.rawValue)\(host.rawValue)"
    }
}
