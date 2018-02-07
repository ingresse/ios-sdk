//
//  RestClient.swift
//  IngresseSDK
//
//  Created by Rubens Gondek on 1/17/17.
//  Copyright © 2017 Gondek. All rights reserved.
//

public class RestClient: NSObject, RestClientInterface {
    
    /// REST GET Method using NSURLConnection
    ///
    /// - Parameters:
    ///   - url: request path
    ///   - onSuccess: success callback
    ///   - onError: fail callback
    public func GET(url: String, onSuccess: @escaping (_ responseData:[String:Any]) -> (), onError: @escaping (_ error: APIError) -> ()) {
        let request = URLRequest(url: URL(string: url)!, cachePolicy: .useProtocolCachePolicy, timeoutInterval: 60)
        
        NSURLConnection.sendAsynchronousRequest(request, queue: OperationQueue()) { (response:URLResponse?, data:Data?, error:Error?) in
            guard error == nil else {
                let errorData = APIError.Builder()
                    .setCode(0)
                    .setError(error!.localizedDescription)
                    .build()

                onError(errorData)
                return
            }
            
            do {
                try ResponseParser.build(response, data: data, completion: { (responseData:[String : Any]) in
                    onSuccess(responseData)
                })
            } catch IngresseException.apiError(let apiError) {
                onError(apiError)
            } catch {
                onError(APIError.getDefaultError())
            }
        }
    }
    
    /// REST POST Method using NSURLConnection
    ///
    /// - Parameters:
    ///   - url: request path
    ///   - parameters: post body parameters
    ///   - onSuccess: success callback
    ///   - onError: fail callback
    public func POST(url: String, parameters: [String:Any], onSuccess: @escaping (_ responseData:[String:Any]) -> (), onError: @escaping (_ error: APIError) -> ()) {
        
        var request = URLRequest(url: URL(string: url)!, cachePolicy: .useProtocolCachePolicy, timeoutInterval: 60)
        request.httpMethod = "POST"
        
        let body = parameters.stringFromHttpParameters()
        
        request.httpBody = body.data(using: .utf8)
        
        NSURLConnection.sendAsynchronousRequest(request, queue: OperationQueue()) { (response:URLResponse?, data:Data?, error:Error?) in
            guard error == nil else {
                onError(APIError.getDefaultError())
                return
            }
            
            do {
                try ResponseParser.build(response, data: data, completion: { (responseData:[String : Any]) in
                    onSuccess(responseData)
                })
            } catch IngresseException.apiError(let apiError) {
                onError(apiError)
            } catch {
                onError(APIError.getDefaultError())
            }
        }
    }
}
