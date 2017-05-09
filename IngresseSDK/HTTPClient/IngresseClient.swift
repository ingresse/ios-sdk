//
//  IngresseClient.swift
//  IngresseSDK
//
//  Created by Rubens Gondek on 1/17/17.
//  Copyright © 2017 Gondek. All rights reserved.
//

import UIKit

public class IngresseClient {
    
    var host: String
    var privateKey: String
    var publicKey: String
    var restClient: RestClientInterface
    
    public init(publicKey: String, privateKey: String, urlHost: String = "https://api.ingresse.com/", restClient: RestClientInterface) {
        self.publicKey = publicKey
        self.privateKey = privateKey
        self.restClient = restClient
        self.host = urlHost
    }
    
    public init(publicKey: String, privateKey: String, urlHost: String = "https://api.ingresse.com/") {
        self.publicKey = publicKey
        self.privateKey = privateKey
        self.restClient = RestClient()
        self.host = urlHost
    }
}
