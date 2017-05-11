//
//  URLBuilder.swift
//  IngresseSDK
//
//  Created by Rubens Gondek on 1/10/17.
//  Copyright © 2017 Gondek. All rights reserved.
//

import Foundation

public class URLBuilder: NSObject {
    
    public static func makeURL(host: String, path: String, publicKey:String, privateKey:String, parameters: [String : String] = [:]) -> String {
        var url = host
        url += path
        url += "?"
        
        if !parameters.isEmpty {
            url += parameters.stringFromHttpParameters()
            url += "&"
        }
        
        url += generateAuthString(publicKey: publicKey, privateKey: privateKey)
        
        return url
    }
    
    public static func generateAuthString(publicKey: String, privateKey: String) -> String {
        let timestamp = getTimestamp()
        let signature = getSignature(publicKey, privateKey, timestamp)
        
        return "publickey=\(publicKey)&signature=\(signature)&timestamp=\(timestamp)"
    }
    
    public static func getTimestamp() -> String {
        let df = DateFormatter()
        df.dateFormat = "yyyy-MM-dd'T'HH:mm:ss'Z'"
        df.timeZone = TimeZone(abbreviation: "GMT")
        df.locale = Locale(identifier: "en_US_POSIX")
        
        let date = Date()
        
        return df.string(from: date)
    }
    
    public static func getSignature(_ publicKey:String,_ privateKey:String,_ timestamp:String) -> String {
        let data = publicKey.appending(timestamp)
        
        let signature = HMACSHA1.hash(data, key: privateKey)!
        
        return signature.stringWithPercentEncoding()!
    }
}
