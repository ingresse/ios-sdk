//
//  Copyright © 2017 Gondek. All rights reserved.
//

public class IngresseClient: NSObject {
    var host: String
    var apiKey: String
    var restClient: RestClientInterface
    
    public init(apiKey: String, userAgent: String, urlHost: String = "https://api.ingresse.com/", restClient: RestClientInterface? = nil) {
        self.apiKey = apiKey
        self.restClient = restClient ?? RestClient()
        self.host = urlHost
        UserAgent.header = userAgent
    }
}
