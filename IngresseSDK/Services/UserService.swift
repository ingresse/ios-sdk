//
//  UserService.swift
//  IngresseSDK
//
//  Created by Marcelo Bissuh on 20/07/17.
//  Copyright © 2017 Ingresse. All rights reserved.
//

import UIKit

@objc public protocol UserEventsDownloaderDelegate {
    
    func didDownloadEvents(_ userEvents: [[String: Any]])
    func didFailDownloadEvents(errorData: APIError)
    
}

public class UserService: NSObject {

    var client: IngresseClient
    
    init(_ client:IngresseClient) {
        self.client = client
    }
    
    public func getEvents(fromUsertoken usertoken: String, page: Int = 1, delegate: UserEventsDownloaderDelegate) {
        
        let userId = usertoken.components(separatedBy: "-").first!
        let path = "user/\(userId)/events"
        let params = [
            "page" : String(page),
            "usertoken" : usertoken
        ]
        
        let url = URLBuilder.makeURL(host: client.host, path: path, publicKey: client.publicKey, privateKey: client.privateKey, parameters: params)
        
        client.restClient.GET(url: url) { (success, response) in
            
            if !success {
                return
            }
            
            var events = [Event]()
            
            guard let data = response["data"] as? [[String:Any]] else {
                delegate.didFailDownloadEvents(errorData: APIError.getDefaultError())
                return
            }
            
            delegate.didDownloadEvents(data)
        }
        
    }
    
    /**
     Get user information
     
     - parameter userId: User ID
     - parameter completion: Callback block
     */
    public func getUser(userId:Int, userToken: String = "", completion: @escaping (_ success: Bool, _ response:[String:Any]?)->()) {
        
        let path = "user/\(userId)"
        let params = [
            "fields" : "id,name,email,pictures",
            "usertoken" : userToken
        ]
        
        let url = URLBuilder.makeURL(host: client.host, path: path, publicKey: client.publicKey, privateKey: client.privateKey, parameters: params)
        
        client.restClient.GET(url: url) { (success: Bool, response: [String:Any]?) in
            if !success {
                completion(false, response)
                return
            }
            
            let user = self.userApiToDict(response!)
            
            completion(true, user)
        }
    }
    
    private func userApiToDict(_ apiResponse: [String:Any]) -> [String:Any] {
        
        var dict : [String:Any] = [:]
        
        dict["name"]       = (apiResponse["name"] as? String) ?? ""
        dict["email"]      = (apiResponse["email"] as? String) ?? ""
        
        var picturesDict : [String:String] = [:]
        
        if let pictures = apiResponse["pictures"] as? [String:String] {
            picturesDict["small"] = pictures["small"]
            picturesDict["medium"] = pictures["medium"]
            picturesDict["large"] = pictures["large"]
        }
        dict["pictures"] = picturesDict
        
        return dict
        
    }
    
}
