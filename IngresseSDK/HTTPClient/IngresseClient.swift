//
//  IngresseClient.swift
//  IngresseSDK
//
//  Created by Rubens Gondek on 1/17/17.
//  Copyright © 2017 Gondek. All rights reserved.
//

public class IngresseClient: NSObject {
    var host: String
    var privateKey: String
    var publicKey: String
    var restClient: RestClientInterface
    
    public init(publicKey: String, privateKey: String, urlHost: String = "https://api.ingresse.com/", restClient: RestClientInterface? = nil) {
        self.publicKey = publicKey
        self.privateKey = privateKey
        self.restClient = restClient ?? RestClient()
        self.host = urlHost
    }
}
