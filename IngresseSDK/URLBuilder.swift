//
//  URLBuilder.swift
//  IngresseSDK
//
//  Created by Rubens Gondek on 12/8/16.
//  Copyright © 2016 Gondek. All rights reserved.
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
        
        return df.string(from: Date())
    }
    
    func getSignature() -> String {
        let timestamp = getTimestamp()
        return timestamp
    }
}
