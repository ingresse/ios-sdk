//
//  IngresseService_Auth.swift
//  IngresseSDK
//
//  Created by Rubens Gondek on 1/16/17.
//  Copyright © 2017 Gondek. All rights reserved.
//

import UIKit

extension IngresseService {

    /**
        Get attributes of event
     
        - parameter eventCode: ID of the event
        - parameter page:      Current page
        - parameter userToken: Token of user
     
        - parameter completionHandler: Callback block in case of success
     */
    public func loginWithEmail(_ email:String, andPassword pass:String, completion: @escaping (_ success: Bool, _ ingUser:IngresseUser?)->()) {
        let path = "login/"
        let params = ["email"    : email,
                      "password" : pass]
        
        let url = makeURL(path, parameters: [:], userToken: nil)
        
        POST(url, parameters: params) { (success: Bool, response: [String:Any]) in
            if success {
                guard let logged = response["status"] as? Bool else {
                    completion(false, nil)
                    return
                }
                
                if logged {
                    guard let data = response["data"] as? [String:Any] else {
                        completion(false, nil)
                        return
                    }
                    
                    let user = IngresseUser.login(userData: data)
                
                    completion(true, user)
                } else {
                    completion(false, nil)
                }
            } else {
                completion(false, nil)
            }
        }
    }
}
