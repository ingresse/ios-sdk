//
//  Copyright © 2017 Gondek. All rights reserved.
//

public class URLBuilder: NSObject {
    
    private var url: String = ""
    private var host: String = ""
    private var path: String = ""
    private var apiKey: String = ""
    private var parameters: [String:String] = [:]
    
    public init(client: IngresseClient) {
        self.host = client.host
        self.apiKey = client.apiKey
    }
    
    public func setHost(_ hostUrl: String) -> URLBuilder {
        self.host = hostUrl
        
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
        var url = self.host
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
}
