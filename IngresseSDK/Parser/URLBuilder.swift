//
//  URLBuilder.swift
//  IngresseSDK
//
//  Created by Rubens Gondek on 1/10/17.
//  Copyright © 2017 Gondek. All rights reserved.
//

public class URLBuilder: NSObject {
    
    private var url: String = ""
    private var host: String = ""
    private var path: String = ""
    private var publicKey: String = ""
    private var privateKey: String = ""
    private var parameters: [String:String] = [:]
    
    public init(client: IngresseClient) {
        self.host = client.host
        self.publicKey = client.publicKey
        self.privateKey = client.privateKey
    }
    
    public func setHost(_ hostUrl: String) -> URLBuilder {
        self.host = hostUrl
        
        return self
    }
    
    public func setPath(_ path: String) -> URLBuilder {
        self.path = path
        
        return self
    }
    
    public func setKeys(publicKey: String, privateKey: String) -> URLBuilder {
        self.publicKey = publicKey
        self.privateKey = privateKey
        
        return self
    }
    
    public func addParameter(key: String, value: Any) -> URLBuilder {
        self.parameters[key] = String(describing: value)
        
        return self
    }
    
    public func build() -> String {
        var url = buildWithoutKeys()
        
        if !parameters.isEmpty {
            url += "&"
        }
        
        url += generateAuthString(publicKey: publicKey, privateKey: privateKey)

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
    ///   - publicKey: app's public key
    ///   - privateKey: app's private key
    /// - Returns: Auth string with public key, signature and timestamp
    public func generateAuthString(publicKey: String, privateKey: String) -> String {
        let timestamp = getTimestamp()
        let signature = getSignature(publicKey, privateKey, timestamp)
        
        return "publickey=\(publicKey)&signature=\(signature)&timestamp=\(timestamp)"
    }
    
    /// Timestamp string
    public func getTimestamp() -> String {
        return Date().toString(format: .gmtTimestamp)
    }
    
    /// Ingresse signature string
    ///
    /// - Parameters:
    ///   - publicKey: app's public key
    ///   - privateKey: app's private key
    ///   - timestamp: current timestamp
    /// - Returns: Encrypted signature
    public func getSignature(_ publicKey:String,_ privateKey:String,_ timestamp:String) -> String {
        let data = publicKey.appending(timestamp)
        
        let signature = HMACSHA1.hash(data, key: privateKey)!
        
        return signature.stringWithPercentEncoding()!
    }
}
