//
//  IngresseService.swift
//  IngresseSDK
//
//  Created by Rubens Gondek on 12/8/16.
//  Copyright © 2016 Gondek. All rights reserved.
//

import Foundation

public enum APIHost: Int {
    case prod, homolog, mock
}

public class IngresseService {
    
    let apiProdURL = "https://api.ingresse.com/"
    let apiHMLURL = "https://apihml.ingresse.com/"
    let apiaryMockURL = "https://private-89bd00-ingresseapi.apiary-mock.com/"
    
    var publicKey: String
    var privateKey: String
    var host: APIHost?
    var urlHost: String
    
    public init () {
        self.publicKey = ""
        self.privateKey = ""
        self.urlHost = ""
        self.host = .prod
    }
    
    public init (publicKey: String, privateKey: String, host: APIHost) {
        self.publicKey = publicKey
        self.privateKey = privateKey
        self.host = host
        
        var url = ""
        switch host {
        case .prod:
            url = apiProdURL
        case .homolog:
            url = apiHMLURL
        case .mock:
            url = apiaryMockURL
        }
        
        self.urlHost = url
    }
    
    public init (publicKey: String, privateKey: String, url: String) {
        self.publicKey = publicKey
        self.privateKey = privateKey
        self.urlHost = url
    }
    
    func makeURL(_ path: String, parameters: [String:String],  userToken: String?) -> String {
        var URL = urlHost
        URL += path
        URL += generateAuthString()
        
        for key in parameters.keys {
            URL += "&\(key)=\(parameters[key]!)"
        }
        
        if (userToken != nil) {
            URL += "&usertoken=\(userToken!)"
        }
        
        return URL
    }
    
    func GET(_ url: String, handler: @escaping ( _ success: Bool, _ response: [String:Any])->()) {
        let request = URLRequest(url: URL(string: url)!, cachePolicy: .useProtocolCachePolicy, timeoutInterval: 15)
        
        NSURLConnection.sendAsynchronousRequest(request, queue: OperationQueue()) { (response:URLResponse?, data:Data?, error:Error?) in
            DispatchQueue.main.async {
                do {
                    try IngresseAPIBuilder.build(response, data: data, error: error, completionHandler: { (responseData:[String : Any]) in
                        handler(true, responseData)
                    })
                } catch IngresseAPIError.errorWithCode(let code) {
//                    IngresseAlerts.errorAlert(errorCode: code, vc: nil)
                    handler(false, ["errorCode":code])
                } catch {
//                    IngresseAlerts.showRequestErrorAlert(onViewController: nil, completion: {
//                        handler([:], false)
//                    })
                }
            }
        }
    }
    
    func POST(_ url: String, parameters: [String : AnyObject], handler: @escaping (_ success: Bool, _ response: [String:Any]) -> ()) {
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
                do {
                    try IngresseAPIBuilder.build(response, data: data, error: error, completionHandler: { (response:[String:Any]) in
                        handler(true, response)
                    })
                } catch IngresseAPIError.errorWithCode(let code) {
//                    IngresseAlerts.errorAlert(errorCode: code, vc: nil)
                    handler(false, ["errorCode":code])
                } catch {
//                    IngresseAlerts.showRequestErrorAlert(onViewController: nil, completion: { () in
//                        handler(false, [:])
//                    })
                }
            }
        }
    }
    
    public func generateAuthString() -> String {
        return URLBuilder(self).generateAuthString()
    }
}
