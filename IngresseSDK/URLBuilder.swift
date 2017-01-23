//
//  URLBuilder.swift
//  IngresseSDK
//
//  Created by Rubens Gondek on 1/10/17.
//  Copyright © 2017 Gondek. All rights reserved.
//

import Foundation

public class URLBuilder {
    
    public static func makeURL(host: String, path: String, publicKey:String, privateKey:String, parameters: [String : String]?) -> String {
        var url = host
        url += path
        url += "?"
        
        if parameters != nil && !parameters!.isEmpty {
            url += parameters!.stringFromHttpParameters()
            url += "&"
        }
        
        url += generateAuthString(publicKey: publicKey, privateKey: privateKey)
        
        return url
    }
    
    public static func generateAuthString(publicKey: String, privateKey: String) -> String {
        let signature = getSignature(publicKey, privateKey)
        let timestamp = getTimestamp()
        
        return "publickey=\(publicKey)&signature=\(signature)&timestamp=\(timestamp)"
    }
    
    public static func getTimestamp() -> String {
        let df = DateFormatter()
        df.dateFormat = "yyyy-MM-dd'T'HH:mm:ss'Z'"
        df.timeZone = TimeZone(abbreviation: "GMT")
        df.locale = Locale(identifier: "en_US_POSIX")
        
        return df.string(from: Date()).removingPercentEncoding!
    }
    
    public static func getSignature(_ publicKey:String,_ privateKey:String) -> String {
        let timestamp = getTimestamp()
        
        let data = publicKey.appending(timestamp)
        
        return HMACSHA1.hash(data, key: privateKey)
    }
}
