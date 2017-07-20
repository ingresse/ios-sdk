//
//  AuthService.swift
//  IngresseSDK
//
//  Created by Rubens Gondek on 1/20/17.
//  Copyright © 2017 Gondek. All rights reserved.
//

public class AuthService: NSObject {

    var client: IngresseClient

    init(_ client: IngresseClient) {
        self.client = client
    }

    /// Login with email and password
    ///
    /// - Parameters:
    ///   - email: user's email
    ///   - pass: password
    ///   - onSuccess: Success callback
    ///   - onError: Fail callback
    public func loginWithEmail(_ email: String, andPassword pass: String, onSuccess: @escaping (_ response: IngresseUser) -> (), onError: @escaping (_ error: APIError) -> ()) {
        
        let url = URLBuilder()
            .setKeys(publicKey: client.publicKey, privateKey: client.privateKey)
            .setHost(client.host)
            .setPath("login/")
            .build()
        
        let params = ["email": email,
                      "password": pass]

        client.restClient.POST(url: url, parameters: params, onSuccess: { (response: [String:Any]) in
            
            guard let logged = response["status"] as? Bool,
                logged,
                let data = response["data"] as? [String:Any]
                else {
                onError(APIError.getDefaultError())
                return
            }
            
            let user = IngresseUser.login(loginData: data)
            
            onSuccess(user)
        }) { (error: APIError) in
            onError(error)
        }
    }
    
    /// Complete user data
    ///
    /// - Parameters:
    ///   - userId: Logged user's id
    ///   - userToken: Logged user's token
    ///   - fields: User attributes to get from API
    ///   - onSuccess: Success callback
    ///   - onError: Fail callback
    public func getUserData(_ userId:String,_ userToken: String,_ fields:String?, onSuccess: @escaping (_ user:IngresseUser)->(), onError: @escaping (_ error: APIError)->()) {
        
        let fieldsValue = fields ?? "id,name,lastname,email,zip,number,complement,city,state,street,district,phone,verified,fbUserId"
        
        let url = URLBuilder()
            .setKeys(publicKey: client.publicKey, privateKey: client.privateKey)
            .setHost(client.host)
            .setPath("user/\(userId)")
            .addParameter(key: "usertoken", value: userToken)
            .addParameter(key: "fields", value: fieldsValue)
            .build()
        
        client.restClient.GET(url: url, onSuccess: { (response: [String:Any]) in
            IngresseUser.fillData(userData: response)
            
            onSuccess(IngresseUser.user!)
        }) { (error: APIError) in
            onError(error)
        }
    }
}
