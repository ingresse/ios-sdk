//
//  RestClient.swift
//  IngresseSDK
//
//  Created by Rubens Gondek on 1/17/17.
//  Copyright © 2017 Gondek. All rights reserved.
//

import UIKit

public class RestClient: RestClientInterface {
    
    /**
     REST GET Method using NSURLConnection
     
     - parameter url: Request path
     
     - parameter completion: Callback block in case of success
     */
    public func GET(url: String, completion:@escaping (_ success:Bool,_ responseData:[String:Any]?) -> ()) {
        let request = URLRequest(url: URL(string: url)!, cachePolicy: .useProtocolCachePolicy, timeoutInterval: 15)
        
        NSURLConnection.sendAsynchronousRequest(request, queue: OperationQueue()) { (response:URLResponse?, data:Data?, error:Error?) in
            DispatchQueue.main.async {
                if error != nil {
                    completion(false, ["requestError":error!])
                    return
                }
                
                do {
                    try ResponseParser.build(response, data: data, completion: { (responseData:[String : Any]) in
                        completion(true, responseData)
                    })
                } catch IngresseException.errorWithCode(let code) {
                    completion(false, ["errorCode":code])
                } catch {
                    completion(false, nil)
                }
            }
        }
    }
    
    /**
     REST POST Method using NSURLConnection
     
     - parameter url:        Request path
     - parameter parameters: Post body parameters
     
     - parameter completion: Callback block in case of success
     */
    public func POST(url: String, parameters: [String:String], completion:@escaping (_ success:Bool,_ responseData:[String:Any]?) -> ()) {
        
        var request = URLRequest(url: URL(string: url)!, cachePolicy: .useProtocolCachePolicy, timeoutInterval: 20)
        request.httpMethod = "POST"
        
        let count = parameters.count
        var i = 1
        
        var body = ""
        for key in parameters.keys {
            body += "\(key)=\(parameters[key]!)"
            if i != count {
                body += "&"
            }
            i += 1
        }
        
        request.httpBody = body.data(using: .utf8)
        
        NSURLConnection.sendAsynchronousRequest(request, queue: OperationQueue()) { (response:URLResponse?, data:Data?, error:Error?) in
            DispatchQueue.main.async {
                if error != nil {
                    completion(false, ["requestError":error!])
                    return
                }
                
                do {
                    try ResponseParser.build(response, data: data, completion: { (responseData:[String:Any]) in
                        completion(true, responseData)
                    })
                } catch IngresseException.errorWithCode(let code) {
                    completion(false, ["errorCode":code])
                } catch {
                    completion(false, nil)
                }
            }
        }
    }
}
