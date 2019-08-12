//
//  Copyright © 2017 Gondek. All rights reserved.
//

public class IngresseClient: NSObject {
    var environment: Environment
    var apiKey: String
    var restClient: RestClientInterface
    
    public init(apiKey: String, userAgent: String, authorization: String = "", env: Environment = .hmla, restClient: RestClientInterface? = nil) {
        self.apiKey = apiKey
        self.restClient = restClient ?? RestClient()
        self.environment = env
        UserAgent.header = userAgent
        UserAgent.authorization = authorization
    }
}
