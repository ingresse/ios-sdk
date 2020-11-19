//
//  Copyright © 2017 Gondek. All rights reserved.
//

public class IngresseClient: NSObject {
    var environment: Environment
    var apiKey: String
    var restClient: RestClientInterface
    var userAgent: String
    var authToken: String
    
    public init(apiKey: String,
                userAgent: String,
                authToken: String,
                env: Environment = .prod,
                restClient: RestClientInterface? = nil) {

        self.apiKey = apiKey
        self.restClient = restClient ?? RestClient()
        self.environment = env
        self.userAgent = userAgent
        self.authToken = authToken

        UserAgent.header = userAgent
        UserAgent.authorization = authToken
    }
}
