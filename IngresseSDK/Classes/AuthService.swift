//
//  AuthService.swift
//  IngresseSDK
//
//  Created by Rubens Gondek on 1/20/17.
//  Copyright © 2017 Gondek. All rights reserved.
//

import Foundation

public class AuthService {
    
    var client: IngresseClient
    
    init(_ client: IngresseClient) {
        self.client = client
    }
    
    /**
     Login into Ingresse and get token and userID
     
     - parameter email: User email
     - parameter pass:  User password
     
     - parameter completion: Callback block
     */
    public func loginWithEmail(_ email:String, andPassword pass:String, completion: @escaping (_ success: Bool, _ response:[String:Any]?)->()) {
        let path = "login/"
        let params = ["email"    : email,
                      "password" : pass]
        
        let url = URLBuilder.makeURL(host: client.host, path: path, publicKey: client.publicKey, privateKey: client.privateKey, parameters: [:])
        
        client.restClient.POST(url: url, parameters: params) { (success: Bool, response: [String:Any]?) in
            if !success {
                completion(false, response)
                return
            }
            
            guard let logged = response!["status"] as? Bool else {
                completion(false, nil)
                return
            }
            
            if !logged {
                completion(false, ["error":"loginFail"])
                return
            }
            
            guard let data = response!["data"] as? [String:Any] else {
                completion(false, ["error":""])
                return
            }
            
            let user = IngresseUser.login(userData: data)
            
            completion(true, ["user":user])
        }
    }
    
    /**
     Get user information
     
     - parameter user: User data
     - parameter fields: Desired info from user
     
     - parameter completion: Callback block
     */
    public func getUserData(_ user:IngresseUser,_ fields:String?, completion: @escaping (_ success: Bool, _ response:[String:Any]?)->()) {
        
        let path = "user/\(user.userId)"
        
        var params = ["usertoken": user.userToken]
        
        params["fields"] = fields ?? "id,name,lastname,email,zip,number,complement,city,state,street,district,phone,verified,fbUserId"
        
        let url = URLBuilder.makeURL(host: client.host, path: path, publicKey: client.publicKey, privateKey: client.privateKey, parameters: params)
        
        client.restClient.GET(url: url) { (success: Bool, response: [String:Any]?) in
            if !success {
                completion(false, response)
                return
            }
            
            let user = IngresseUser.fillData(userData: response!)
            
            completion(true, ["user":user as Any])
        }
    }
}
