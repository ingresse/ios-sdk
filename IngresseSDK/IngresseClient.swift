
//
//  IngresseClient.swift
//  IngresseSDK
//
//  Created by Rubens Gondek on 1/17/17.
//  Copyright © 2017 Gondek. All rights reserved.
//

import UIKit

public class IngresseClient {
    
    var host: String
    var privateKey: String
    var publicKey: String
    var client: RestClientInterface
    
    public init(publicKey: String, privateKey: String, urlHost: String, client: RestClientInterface) {
        self.publicKey = publicKey
        self.privateKey = privateKey
        self.client = client
        self.host = urlHost
    }
    
    public init(publicKey: String, privateKey: String, urlHost: String) {
        self.publicKey = publicKey
        self.privateKey = privateKey
        self.client = RestClient()
        self.host = urlHost
    }
    
    public init(publicKey: String, privateKey: String) {
        self.publicKey = publicKey
        self.privateKey = privateKey
        self.client = RestClient()
        self.host = "https://api.ingresse.com/"
    }
    
    func makeURL(path: String, parameters: [String : String]) -> String {
        var URL = host
        URL += path
        URL += URLBuilder.generateAuthString(publicKey: publicKey, privateKey: privateKey)
        
        for key in parameters.keys {
            URL += "&\(key)=\(parameters[key]!)"
        }
        
        return URL
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
        
        let url = makeURL(path: path, parameters: [:])
        
        client.POST(url: url, parameters: params) { (success: Bool, response: [String:Any]?) in
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
        
        let path = "user/\(user.userId!)"
        
        var params = ["usertoken": user.userToken!]
        
        params["fields"] = fields ?? "id,name,lastname,email,zip,number,complement,city,state,street,district,phone,verified,fbUserId"
        
        let url = makeURL(path: path, parameters: params)
        
        client.GET(url: url) { (success: Bool, response: [String:Any]?) in
            if !success {
                completion(false, response)
                return
            }
            
            let user = IngresseUser.fillData(userData: response!)
            
            completion(true, ["user":user])
        }
    }
    
}
