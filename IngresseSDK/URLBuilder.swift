//
//  URLBuilder.swift
//  IngresseSDK
//
//  Created by Rubens Gondek on 1/10/17.
//  Copyright © 2017 Gondek. All rights reserved.
//

import Foundation

class URLBuilder {
    
    var service: IngresseService!
    
    init (_ service: IngresseService) {
        self.service = service
    }
    
    func generateAuthString() -> String {
        return "?publickey=\(service.publicKey)&signature=\(getSignature())&timestamp=\(getTimestamp())"
    }
    
    func getTimestamp() -> String {
        let df = DateFormatter()
        df.dateFormat = "yyyy-MM-dd'T'HH:mm:ss'Z'"
        df.timeZone = TimeZone(abbreviation: "GMT")
        df.locale = Locale(identifier: "en_US_POSIX")
        
        return df.string(from: Date()).removingPercentEncoding!
    }
    
    func getSignature() -> String {
        let timestamp = getTimestamp()
        
        let data = service.publicKey.appending(timestamp)
        
        return HMACSHA1.hash(data, key: service.privateKey)
    }
}


